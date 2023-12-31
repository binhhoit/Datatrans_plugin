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
    private(set) var cards: CardInfo?
    private(set) var paymentMethod: [String]
    private(set) var amount: Int64
    
    init(currency: String,
         referenceNo: String,
         autoSettle: Bool,
         saveAlias: Bool,
         cards: CardInfo? = nil,
         paymentMethod: [String],
         amount: Int64) {
        self.currency = currency
        self.referenceNo = referenceNo
        self.autoSettle = autoSettle
        self.saveAlias = saveAlias
        self.cards = cards
        self.paymentMethod = paymentMethod
        self.amount = amount
    }
    
    convenience init(dict: [String: Any]) {
        let currency = (dict["currency"] as? String) ?? ""
        let referenceNo = "\(Date().timeIntervalSince1970)"
        let autoSettle = (dict["autoSettle"] as? Bool) ?? false
        let saveAlias = (dict["saveAlias"] as? Bool) ?? false
        let paymentMethod = (dict["paymentMethods"] as? [String]) ?? []
        let amount = (dict["amount"] as? Int64) ?? 0
        var cardInfo: CardInfo? = nil
        if let card = dict["card"] as? [String: Any] {
            cardInfo = CardInfo(dict: card)
        }
        
        self.init(currency: currency,
                  referenceNo: referenceNo,
                  autoSettle: autoSettle,
                  saveAlias: saveAlias,
                  cards: cardInfo,
                  paymentMethod: paymentMethod,
                  amount: amount)
    }
    
    public func toParams() -> Parameters {
        var parameters: Parameters = [
            "currency": currency,
            "refno": referenceNo,
            "amount": amount,
            "paymentMethods": paymentMethod,
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
        
        if let params = cards?.toParams() {
            parameters["card"] = params
        }
        return parameters
    }
}
