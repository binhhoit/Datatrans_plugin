package com.sts.datatrans_plugin_flutter

import android.app.Activity
import android.content.Context
import android.util.Log
import androidx.lifecycle.lifecycleScope
import ch.datatrans.payment.api.DCCShowMode
import ch.datatrans.payment.api.Transaction
import ch.datatrans.payment.api.TransactionListener
import ch.datatrans.payment.api.TransactionRegistry
import ch.datatrans.payment.api.TransactionSuccess
import ch.datatrans.payment.exception.TransactionException
import ch.datatrans.payment.paymentmethods.CardExpiryDate
import ch.datatrans.payment.paymentmethods.PaymentMethodType
import ch.datatrans.payment.paymentmethods.SavedCard
import com.google.gson.Gson
import com.sts.datatrans_plugin_flutter.data.model.DatatransRequest
import com.sts.datatrans_plugin_flutter.data.model.ExpiredDate
import com.sts.datatrans_plugin_flutter.data.model.ResultResponsePayment
import com.sts.datatrans_plugin_flutter.data.model.SaveCardPayment
import com.sts.datatrans_plugin_flutter.data.repository.DatatransRepository
import com.sts.datatrans_plugin_flutter.util.encode
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlinx.coroutines.launch

/** DatatransFlutterPlugin */
class DatatransFlutterPlugin : MethodCallHandler, FlutterPlugin, ActivityAware {

    companion object {
        const val TAG = "DatatransPlugin"
        const val NAME = "datatrans_plugin_flutter"
    }

    private lateinit var context: Context
    private var activity: Activity? = null
    private lateinit var channel: MethodChannel
    private lateinit var transaction: Transaction
    private var repository: DatatransRepository
    private var result: Result? = null
    private var authorization: String? = null
    private var tokenPayment: String? = null
    private var isTesting = false

    init {
        if (isTesting) {
            Log.d(TAG, "init")
        }
        repository = DatatransRepository()
    }

    private fun initSDKDataTransaction(savedPaymentMethod: SavedCard? = null) {
        if (tokenPayment == null) {
            return
        }
        transaction =
            if (savedPaymentMethod != null) {
                Transaction(tokenPayment!!, savedPaymentMethod)
            } else {
                Transaction(tokenPayment!!)
            }

        transaction.apply {
            options.appCallbackScheme = "app.datatrans.flutter"
            listener = object : TransactionListener {
                override fun onTransactionError(exception: TransactionException) {
                    exception.printStackTrace()
                    result?.success(
                        ResultResponsePayment(
                            success = false,
                            error = exception.message,
                            bodyError = exception,
                        ).toJson(),
                    )
                }

                override fun onTransactionSuccess(result: TransactionSuccess) {
                    val data = try {
                        (result.savedPaymentMethod as SavedCard).let {
                            SaveCardPayment(
                                it.alias,
                                it.maskedCardNumber ?: "",
                                it.cardholder ?: "",
                                ExpiredDate(
                                    it.cardExpiryDate?.month ?: 0,
                                    it.cardExpiryDate?.year ?: 0,
                                ),
                                it.type.identifier,
                            )
                        }
                    } catch (e: Exception) {
                        null
                    }

                    this@DatatransFlutterPlugin.result?.success(
                        ResultResponsePayment(
                            success = true,
                            data = data,
                        ).toJson(),
                    )
                }
            }
            options.isTesting = isTesting
            options.useCertificatePinning = false
            options.suppressCriticalErrorDialog = true
            if (activity == null) {
                result?.success(
                    ResultResponsePayment(
                        success = false,
                        error = "Not found activity",
                    ).toJson(),
                )
            } else {
                TransactionRegistry.startTransaction(activity!!, transaction)
            }
        }
        if (isTesting) {
            Log.d(TAG, "install")
        }
    }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, NAME)
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
        if (isTesting) {
            Log.d(TAG, "onAttachedToEngine")
        }
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        this.result = result
        when (call.method) {
            DatatransMethod.INITIALIZE.label -> {
                val merchantId = call.argument<String>("merchantId")
                val password = call.argument<String>("password")
                isTesting = call.argument<Boolean>("isTesting") ?: false
                authorization = "Basic ${("$merchantId:$password").encode()}"
            }

            DatatransMethod.PAYMENT.label -> {
                getTokenMobile(call.argument<Any>("payment") ?: Any())
            }

            DatatransMethod.SAVE_CARD.label -> {
                getTokenMobile(call.argument<Any>("payment") ?: Any())
            }

            DatatransMethod.FAST_PAYMENT.label -> {
                getTokenMobile(
                    call.argument<Any>("payment") ?: Any(),
                    createSaveCardPayment(call.argument<Any>("cards") ?: Any()),
                )
            }

            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
        if (isTesting) {
            Log.d(TAG, "onAttachedToActivity")
        }
    }

    override fun onDetachedFromActivityForConfigChanges() {
        if (isTesting) {
            Log.d(TAG, "Detached")
        }
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        if (isTesting) {
            Log.d(TAG, "Reattached")
        }
    }

    override fun onDetachedFromActivity() {
        if (isTesting) {
            Log.d(TAG, "Detached")
        }
    }

    private fun getTokenMobile(
        argumentsPayment: Any,
        savedPaymentMethod: SavedCard? = null,
    ) {
        (activity as FlutterFragmentActivity).apply {
            lifecycleScope.launch {
                if (authorization == null) {
                    result?.success(
                        ResultResponsePayment(
                            success = false,
                            error = "Authorization not success",
                        ).toJson(),
                    )
                }
                try {
                    repository.getToken(
                        authorization!!,
                        createRequestPayment(argumentsPayment),
                    ).apply {
                        if (isSuccessful) {
                            tokenPayment = this.body()?.mobileToken ?: ""
                            initSDKDataTransaction(savedPaymentMethod)
                        } else {
                            result?.success(
                                ResultResponsePayment(
                                    false,
                                    "Can't get token payment",
                                ).toJson(),
                            )
                        }
                    }
                } catch (e: java.lang.Exception) {
                    result?.success(
                        ResultResponsePayment(
                            success = false,
                            error = e.message,
                            bodyError = e,
                        ).toJson(),
                    )
                }
            }
        }
    }

    private fun createRequestPayment(arguments: Any): DatatransRequest {
        val rawData =
            try {
                Gson().fromJson(
                    arguments.toString(),
                    DatatransRequest::class.java,
                )
            } catch (e: Exception) {
                DatatransRequest("USD", "0", false, listOf("ECA", "VIS"))
            }

        return DatatransRequest(
            rawData.currency,
            rawData.amount,
            rawData.autoSettle,
            rawData.paymentMethods,
        ).apply {
            isSaveAlias = rawData.isSaveAlias
        }
    }

    private fun createSaveCardPayment(arguments: Any): SavedCard {
        val rawData =
            try {
                Gson().fromJson(
                    Gson().toJson(arguments),
                    SaveCardPayment::class.java,
                )
            } catch (e: Exception) {
                SaveCardPayment("", "", "", ExpiredDate(0, 0), "")
            }

        return SavedCard(
            type = PaymentMethodType.fromIdentifier(rawData.paymentMethod)
                ?: PaymentMethodType.VISA,
            alias = rawData.alias,
            cardExpiryDate = CardExpiryDate(
                rawData.expiredDate.month,
                rawData.expiredDate.year,
            ),
            maskedCardNumber = rawData.cardNumber,
            cardholder = rawData.cardHolder,
        )
    }
}
