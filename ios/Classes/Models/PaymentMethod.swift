//
//  PaymentMethod.swift
//  datatrans_plugin_flutter
//
//  Created by Thien.Vu2 on 25/12/2023.
//

import Foundation
import Datatrans

class PaymentMethod {
    private(set) var savePayment: SavedPaymentMethod
    
    init(methodType: PaymentMethodType, 
         alias: String) {
        savePayment = SavedPaymentMethod(type: methodType, alias: alias)
    }
}
