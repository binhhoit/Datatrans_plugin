package com.sts.datatrans_plugin_flutter

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.util.Log
import ch.datatrans.payment.api.Transaction
import ch.datatrans.payment.api.TransactionListener
import ch.datatrans.payment.api.TransactionRegistry
import ch.datatrans.payment.api.TransactionSuccess
import ch.datatrans.payment.exception.TransactionException
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
import java.lang.Exception

/** DatatransPluginFlutterPlugin */
class DatatransPluginFlutterPlugin :
    MethodCallHandler,
    NewIntentListener,
    RequestPermissionsResultListener,
    ActivityResultListener,
    FlutterPlugin,
    ActivityAware {

    companion object {
        const val TOKEN_MOBILE = "770a6711dd257da0dcce5cb706f9e417033579f11c538098"
        const val TAG = "DatatransPlugin"
        const val NAME ="datatrans_plugin_flutter"
    }

    private lateinit var context: Context
    private var activity: Activity? =null
    private lateinit var channel: MethodChannel
    private lateinit var transaction: Transaction

    init {
        Log.e(TAG, "init")
    }

    private fun initSDKDataTransaction() {
        transaction = Transaction(TOKEN_MOBILE)
        transaction.apply {
            //options.appCallbackScheme = "https://sts.com"
            listener = object : TransactionListener {
                override fun onTransactionError(exception: TransactionException) {
                    exception.printStackTrace()
                }

                override fun onTransactionSuccess(result: TransactionSuccess) {
                    result.transactionId
                }
            }
            options.isTesting = true
            options.useCertificatePinning = false
            options.suppressCriticalErrorDialog = true
            if (activity == null) {
                throw Exception("null activity")
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
        if (call.method == "initializeTransaction") {
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
            initSDKDataTransaction()
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onNewIntent(intent: Intent): Boolean {
        Log.e(TAG, "onNewIntent")
        return true
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray,
    ): Boolean {
        return true
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        return true
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
}
