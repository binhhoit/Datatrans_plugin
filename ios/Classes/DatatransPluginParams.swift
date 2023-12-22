//
//  DatatransPluginParams.swift
//  DatatransPlugin
//
//  Created by Thien.Vu2 on 22/12/2023.
//

import Alamofire

class TransactionParams {
    private(set) var currency: String
    private(set) var referenceNo: String
    private(set) var autoSettle: Bool
    private(set) var saveAlias: Bool
    private(set) var paymentMethod: Set<PaymentMethodType>
    private(set) var amount: Int64
    
    init(currency: String, 
         referenceNo: String,
         autoSettle: Bool,
         saveAlias: Bool,
         paymentMethod: Set<PaymentMethodType>,
         amount: Int64) {
        self.currency = currency
        self.referenceNo = referenceNo
        self.autoSettle = autoSettle
        self.saveAlias = saveAlias
        self.paymentMethod = paymentMethod
        self.amount = amount
    }
    
    public func toParams() -> Parameters {
        let parameters: Parameters = [
            "currency": currency,
            "refno": referenceNo,
            "amount": amount,
            "paymentMethods": paymentMethod.map({ $0.rawValue }),
            "autoSettle": autoSettle,
            "option": [
                "createAlias": saveAlias,
                "returnMobileToken": true,
            ],
            "redirect": [
                "successUrl": "https://pay.sandbox.datatrans.com/upp/merchant/successPage.jsp",
                "cancelUrl": "https://pay.sandbox.datatrans.com/upp/merchant/cancelPage.jsp",
                "errorUrl": "https://pay.sandbox.datatrans.com/upp/merchant/errorPage.jsp"
            ]
        ]
        return parameters
    }
}
