//
//  DatatransPluginDefine.swift
//  DatatransPlugin
//
//  Created by Thien.Vu2 on 22/12/2023.
//

import Foundation

class Constants {
    static let apiUrl = "https://api.sandbox.datatrans.com/v1/transactions"
}

enum MethodIdentity: String {
    case initialize = "initialize"
    case saveCardPaymentInfo = "saveCardPaymentInfo"
    case payment = "payment"
}

enum PaymentMethodType: String {
    case masterCard = "ECA"
    case visa = "VIS"
    case paypal = "PAP"
    case americanExpress = "AMX"
    case chinnaUnion = "CUP"
    case dinnerClub = "DIN"
    case discover = "DIS"
    case jcb = "JCB"
    case maestro = "MAU"
    case dankort = "DNK"
}
