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
    case fastPayment = "fastPayment"
}
