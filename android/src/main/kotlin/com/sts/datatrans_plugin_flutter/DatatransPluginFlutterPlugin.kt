package com.sts.datatrans_plugin_flutter

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

/** DatatransPluginFlutterPlugin */
class DatatransPluginFlutterPlugin : MethodCallHandler,
    NewIntentListener,
    RequestPermissionsResultListener,
    ActivityResultListener,
    FlutterPlugin,
    ActivityAware {

    companion object {
        const val TOKEN_MOBILE = "d065e4d4261c6f4c9fac7b92c373976c0335774464a25674";
    }

    private lateinit var context:Context
    private lateinit var channel: MethodChannel
    private val transaction = Transaction(TOKEN_MOBILE)


    init {
        transaction.apply {
            options.appCallbackScheme = "com.sts.datatrans_plugin_flutter_example"
            listener = object :TransactionListener {
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
        }
    }


    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "datatrans_plugin_flutter")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "getPlatformVersion") {
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onNewIntent(intent: Intent): Boolean {
      Log.e("activity", "onNewIntent")
      return true
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray,
    ): Boolean {
        TODO("Not yet implemented")
    }

    override fun onActivityResult(
        requestCode: Int,
        resultCode: Int,
        data: Intent?,
    ): Boolean {
        TODO("Not yet implemented")
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
      context = binding.activity
      TransactionRegistry.startTransaction(binding.activity, transaction)
    }

    override fun onDetachedFromActivityForConfigChanges() {
       Log.e("activity", "Detached")
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
      Log.e("activity", "Reattached")
    }

    override fun onDetachedFromActivity() {
      Log.e("activity", "Detached")
    }
}
