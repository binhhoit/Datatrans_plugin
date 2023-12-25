import Flutter
import UIKit

public class DatatransFlutterPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "datatrans_plugin_flutter", binaryMessenger: registrar.messenger())
        let instance = DatatransFlutterPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let identity = MethodIdentity(rawValue: call.method) 
        switch identity {
        case .initialize:
            guard let data = call.arguments as? [String: Any] else {
                return
            }
            let params = TransactionInitializeParams(dict: data)
            DatatransPluginTransaction.instance.configure(merchantId: params.merchantId, password: params.password)
        case .saveCardPaymentInfo:
            return
        case .payment:
            return
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
