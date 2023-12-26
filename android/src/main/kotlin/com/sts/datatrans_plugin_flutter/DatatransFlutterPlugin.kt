package com.sts.datatrans_plugin_flutter

import android.app.Activity
import android.content.Context
import android.util.Log
import androidx.lifecycle.lifecycleScope
import ch.datatrans.payment.api.Transaction
import ch.datatrans.payment.api.TransactionListener
import ch.datatrans.payment.api.TransactionRegistry
import ch.datatrans.payment.api.TransactionSuccess
import ch.datatrans.payment.exception.TransactionException
import ch.datatrans.payment.paymentmethods.SavedCard
import ch.datatrans.payment.paymentmethods.SavedPaymentMethod
import com.google.gson.Gson
import com.sts.datatrans_plugin_flutter.data.model.DatatransRequest
import com.sts.datatrans_plugin_flutter.data.model.ExpiredDate
import com.sts.datatrans_plugin_flutter.data.model.ResultResponsePayment
import com.sts.datatrans_plugin_flutter.data.model.SaveCardPayment
import com.sts.datatrans_plugin_flutter.data.repository.DatatransRepository
import com.sts.datatrans_plugin_flutter.util.encode
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.StandardMessageCodec
import kotlinx.coroutines.launch
import java.lang.Exception

/** DatatransFlutterPlugin */
class DatatransFlutterPlugin : MethodCallHandler, FlutterPlugin, ActivityAware {

    companion object {
        const val TAG = "DatatransPlugin"
        const val NAME ="datatrans_plugin_flutter"
    }

    private lateinit var context: Context
    private var activity: Activity? = null
    private lateinit var channel: MethodChannel
    private lateinit var transaction: Transaction
    private var repository: DatatransRepository
    private var result: Result? = null
    private var authorization: String? = null
    private var tokenPayment: String? = null

    init {
        Log.d(TAG, "init")
        repository = DatatransRepository()
    }

    private fun initSDKDataTransaction(savedPaymentMethod: SavedPaymentMethod? = null) {
        if (tokenPayment == null)
            return
        transaction =
            if (savedPaymentMethod != null)
                Transaction(tokenPayment!!, savedPaymentMethod)
            else Transaction(tokenPayment!!)

        transaction.apply {
            options.appCallbackScheme = "app.datatrans.flutter"
            listener = object : TransactionListener {
                override fun onTransactionError(exception: TransactionException) {
                    exception.printStackTrace()
                    result?.success(ResultResponsePayment(false,exception.message, null).toJson())
                }

                override fun onTransactionSuccess(result: TransactionSuccess) {

                    val data = (result.savedPaymentMethod as SavedCard).let {
                        SaveCardPayment(it.alias,
                            it.maskedCardNumber ?: "",
                            it.cardholder ?: "",
                            ExpiredDate(it.cardExpiryDate?.month ?: 0,
                                it.cardExpiryDate?.year ?: 0),
                            it.type.identifier
                        )
                    }

                    this@DatatransFlutterPlugin.result?.success(
                        ResultResponsePayment(
                            true,
                            null,
                            data,
                        ).toJson())
                }
            }
            options.isTesting = true
            options.useCertificatePinning = false
            options.suppressCriticalErrorDialog = true
            if (activity == null) {
                result?.success(ResultResponsePayment(false,"not found activity", null).toJson())
            } else {
                TransactionRegistry.startTransaction(activity!!, transaction)
            }
        }
        Log.d(TAG, "install")
    }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, NAME)
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
        Log.d(TAG, "onAttachedToEngine")
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        this.result = result
        when (call.method) {
            DatatransMethod.INITIALIZE.label -> {
                val merchantId = call.argument<String>("merchantId")
                val password = call.argument<String>("password")
                authorization = "Basic ${("$merchantId:$password").encode()}"
            }
            DatatransMethod.PAYMENT.label -> {
                getTokenMobile(call.arguments)
            }
            DatatransMethod.SAVE_CARD.label -> {
                getTokenMobile(call.arguments)
            }
            DatatransMethod.FAST_PAYMENT.label -> {
                getTokenMobile(call.arguments)
            }
            else -> result.notImplemented()
        }

    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
        Log.d(TAG, "onAttachedToActivity")
    }

    override fun onDetachedFromActivityForConfigChanges() {
        Log.d(TAG, "Detached")
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        Log.d(TAG, "Reattached")
    }

    override fun onDetachedFromActivity() {
        Log.d(TAG, "Detached")
    }

    private fun getTokenMobile(arguments: Any) {
        (activity as FlutterFragmentActivity).apply {
            lifecycleScope.launch {
                val rawData = Gson().fromJson(arguments.toString(), DatatransRequest::class.java)
                val request = DatatransRequest(
                    rawData.currency,
                    rawData.amount,
                    rawData.autoSettle,
                    rawData.paymentMethods,
                ).apply {
                    isSaveAlias = rawData.isSaveAlias
                }
                if(authorization==null)
                    result?.success(ResultResponsePayment(false,"authorization not success", null).toJson())
                repository.getToken(authorization!!,request).apply {
                    if (isSuccessful) {
                        tokenPayment = this.body()?.mobileToken ?: ""
                        val savedPaymentMethod = Gson().fromJson(arguments.toString(), SavedPaymentMethod::class.java)
                        Log.e(TAG,savedPaymentMethod.toJson())
                        initSDKDataTransaction()
                    } else {
                        result?.success(ResultResponsePayment(false,"can't get token payment", null).toJson())
                    }
                }
            }
        }

    }
}
