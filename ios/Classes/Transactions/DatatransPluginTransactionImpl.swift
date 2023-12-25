//
//  DatatransPluginTransactionImpl.swift
//  datatrans_plugin_flutter
//
//  Created by Thien.Vu2 on 25/12/2023.
//

import Foundation
import Datatrans
import Alamofire

class DatatransPluginTransactionImpl: DatatransPluginTransaction {
    private var hashBasicToken: String = ""
    internal var paymentCompletion: ((Bool) -> Void)?
    
    func configure(params: TransactionInitializeParams) {
        guard let credentialData = "\(params.merchantId):\(params.password)".data(using: String.Encoding.utf8) else {
            return
        }
        
        self.hashBasicToken = credentialData.base64EncodedString(options: [])
    }
    
    func payment(params: TransactionParams) {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json; charset=UTF-8",
            "Authorization": "Basic \(hashBasicToken)"
        ]
        let parameters: Parameters = params.toParams()
        
        AF.request(Constants.apiUrl,
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default, headers: headers)
            .response { response in
                if let data = response.data {
                    do {
                        let data = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        if let mobileToken = data?["mobileToken"] as? String {
                            let transaction = Transaction(mobileToken: mobileToken)
                            transaction.delegate = self
                            transaction.options.testing = true
                            transaction.options.useCertificatePinning = true
                            transaction.options.appCallbackScheme = "app.datatrans.flutter"
                            
                            if let vc = UIApplication.shared.delegate?.window??.rootViewController {
                                DispatchQueue.main.async {
                                    transaction.start(presentingController: vc)
                                }
                            }
                            return
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
    }
}

extension DatatransPluginTransactionImpl: TransactionDelegate {
    func transactionDidFinish(_ transaction: Datatrans.Transaction, result: Datatrans.TransactionSuccess) {
        paymentCompletion?(true)
    }
    
    func transactionDidFail(_ transaction: Datatrans.Transaction, error: Datatrans.TransactionError) {
        paymentCompletion?(false)
    }
}