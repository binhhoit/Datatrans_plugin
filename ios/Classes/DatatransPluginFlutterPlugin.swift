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
            let request = BaseRequest(dict: data)
            guard let request = request else {
                result(BaseReponse.commonErrorResponse)
                return
            }
            
            transaction.paymentCompletion = { response in
                result(response.toJson)
            }
            transaction.payment(params: request.payment)
        case .fastPayment:
            let request = BaseRequest(dict: data)
            guard let request = request,
                  let savePaymentMethod = request.paymentMethod else {
                result(BaseReponse.commonErrorResponse)
                return
            }
            
            transaction.paymentCompletion = { response in
                result(response.toJson)
            }
            transaction.fastPayment(params: request.payment, savePaymentMethod: savePaymentMethod)
            return
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
