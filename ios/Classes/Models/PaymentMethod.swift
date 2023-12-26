//
//  PaymentMethod.swift
//  datatrans_plugin_flutter
//
//  Created by Thien.Vu2 on 25/12/2023.
//

import Foundation
import Datatrans

class PaymentMethod {
    private(set) var savePayment: SavedCard
    
    init(savePayment: SavedCard) {
        self.savePayment = savePayment
    }
    
    convenience init?(dict: [String: Any]) {
        let alias = (dict["alias"] as? String) ?? ""
        let cardNumber = (dict["cardNumber"] as? String) ?? ""
        let cardHolder = (dict["cardHolder"] as? String) ?? ""
        var cardExpiryDate: CardExpiryDate? = nil
        if let expiredDate = dict["expiredDate"] as? [String: Any] {
            cardExpiryDate = CardExpiryDate(dict: expiredDate)
        }
        let value = (dict["paymentMethod"] as? String) ?? ""
        let paymentType = PaymentMethodType.toType(value)
        
        guard let paymentType = paymentType else {
            return nil
        }
        let saveCard = SavedCard(type: paymentType,
                                 alias: alias,
                                 cardExpiryDate: cardExpiryDate,
                                 maskedCardNumber: cardNumber,
                                 cardholder: cardHolder)
        
        self.init(savePayment: saveCard)
    }
    
    func toDict() -> [String: Any?] {
        return [
            "alias": savePayment.alias,
            "cardNumber" : savePayment.maskedCardNumber,
            "cardHolder": savePayment.cardholder,
            "expiredDate": savePayment.cardExpiryDate?.toJson(),
            "paymentMethod": savePayment.type.identity
        ]
    }
}

extension CardExpiryDate {
    convenience init(dict: [String: Any]) {
        let month = dict["month"] as? Int ?? 0
        let year = dict["year"] as? Int ?? 0
        
        self.init(month: month, year: year)
    }
    
    func toJson() -> [String: Any] {
        return [
            "month": month,
            "year" : year
        ]
    }
}

extension PaymentMethodType {
    
    static func toType(_ rawStr: String) -> PaymentMethodType? {
        switch rawStr {
        case "ECA":
            return PaymentMethodType.MasterCard
        case "VIS":
            return PaymentMethodType.Visa
        case "PAP":
            return PaymentMethodType.PayPal
        case "AMX":
            return PaymentMethodType.AmericanExpress
        case "CUP":
            return PaymentMethodType.ChinaUnionPay
        case "DIN":
            return PaymentMethodType.DinersClub
        case "DIS":
            return PaymentMethodType.Discover
        case "JCB":
            return PaymentMethodType.JCB
        case "MAU":
            return PaymentMethodType.Maestro
        case "DNK":
            return PaymentMethodType.Dankort
        default:
            return nil
        }
    }
    
    var identity: String {
        switch self {
        case .MasterCard:
            return "ECA"
        case .Visa:
            return "VIS"
        case .PayPal:
            return "PAP"
        case .AmericanExpress:
            return "AMX"
        case .ChinaUnionPay:
            return "CUP"
        case .DinersClub:
            return "DIN"
        case .Discover:
            return "DIS"
        case .JCB:
            return "JCB"
        case .Maestro:
            return "MAU"
        case .Dankort:
            return "DNK"
        default:
            return ""
        }
    }
}
