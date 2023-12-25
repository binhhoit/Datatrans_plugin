import Flutter
import UIKit

public class DatatransFlutterPlugin: NSObject, FlutterPlugin {
    private var transaction: DatatransPluginTransaction = DatatransPluginTransactionImpl()
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "datatrans_plugin_flutter", binaryMessenger: registrar.messenger())
        let instance = DatatransFlutterPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let data = call.arguments as? [String: Any] else {
            return
        }
        
        let identity = MethodIdentity(rawValue: call.method)
        switch identity {
        case .initialize:
            let params = TransactionInitializeParams(dict: data)
            transaction.configure(params: params)
        case .payment:
            let params = TransactionParams(dict: data)
            transaction.paymentCompletion = { isSuccess in
                result(isSuccess)
            }
            transaction.payment(params: params)
        case .saveCardPaymentInfo:
            return
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
