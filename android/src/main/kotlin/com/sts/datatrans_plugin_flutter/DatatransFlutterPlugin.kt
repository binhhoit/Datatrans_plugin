package com.sts.datatrans_plugin_flutter

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.util.Log
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.DefaultLifecycleObserver
import androidx.lifecycle.lifecycleScope
import ch.datatrans.payment.api.Transaction
import ch.datatrans.payment.api.TransactionListener
import ch.datatrans.payment.api.TransactionRegistry
import ch.datatrans.payment.api.TransactionSuccess
import ch.datatrans.payment.exception.TransactionException
import com.google.gson.Gson
import com.sts.datatrans_plugin_flutter.data.model.DatatransRequest
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
import io.flutter.plugin.common.PluginRegistry.ActivityResultListener
import io.flutter.plugin.common.PluginRegistry.NewIntentListener
import io.flutter.plugin.common.PluginRegistry.RequestPermissionsResultListener
import kotlinx.coroutines.launch
import okio.ByteString.Companion.decodeBase64
import java.lang.Exception
import kotlin.jvm.Throws

/** DatatransFlutterPlugin */
class DatatransFlutterPlugin :
    MethodCallHandler,
    FlutterPlugin,
    ActivityAware {

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
        Log.e(TAG, "init")
        repository = DatatransRepository()
    }

    private fun initSDKDataTransaction() {
        if (tokenPayment == null)
            return
        transaction = Transaction(tokenPayment!!)
        transaction.apply {
            options.appCallbackScheme = "app.datatrans.flutter"
            listener = object : TransactionListener {
                override fun onTransactionError(exception: TransactionException) {
                    this@DatatransFlutterPlugin.result?.error(
                        "400",
                        "Payment error",
                        exception)
                }

                override fun onTransactionSuccess(result: TransactionSuccess) {
                    this@DatatransFlutterPlugin.result?.success(result)
                }
            }
            options.isTesting = true
            options.useCertificatePinning = false
            options.suppressCriticalErrorDialog = true
            if (activity == null) {
                result?.error("400", "null activity", null)
            } else {
                TransactionRegistry.startTransaction(activity!!, transaction)
            }
        }
        Log.e(TAG, "install")
    }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, NAME)
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
        Log.e(TAG, "onAttachedToEngine")
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
        Log.e(TAG, "onAttachedToActivity")
    }

    override fun onDetachedFromActivityForConfigChanges() {
        Log.e(TAG, "Detached")
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        Log.e(TAG, "Reattached")
    }

    override fun onDetachedFromActivity() {
        Log.e(TAG, "Detached")
    }

    private fun getTokenMobile(arguments: Any) {
        (activity as FlutterFragmentActivity).apply {
            lifecycleScope.launch {
                val rawData = Gson().fromJson(arguments.toString(), DatatransRequest::class.java)
                val request = DatatransRequest(rawData.currency, rawData.amount, rawData.paymentMethods)
                if(authorization==null)
                    result?.error("401", "authorization not success", null)
                repository.getToken(authorization!!,request).apply {
                    if (isSuccessful) {
                        tokenPayment = this.body()?.mobileToken ?: ""
                        initSDKDataTransaction()
                    } else {
                        result?.success("can't get token payment")
                    }
                }
            }
        }

    }
}
