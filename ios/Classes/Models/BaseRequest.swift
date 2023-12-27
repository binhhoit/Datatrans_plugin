//
//  BaseRequest.swift
//  datatrans_plugin_flutter
//
//  Created by Thien.Vu2 on 26/12/2023.
//

import Foundation

class BaseRequest {
    let payment: TransactionParams
    let paymentMethod: PaymentMethod?
    
    init(payment: TransactionParams,
         paymentMethod: PaymentMethod? = nil) {
        self.payment = payment
        self.paymentMethod = paymentMethod
    }
    
    convenience init?(dict: [String: Any]) {
        guard let data = dict["payment"] as? [String: Any] else {
            return nil
        }
        let payment = TransactionParams(dict: data)
        
        var paymentMethod: PaymentMethod? = nil
        if let dataCards = dict["cards"] as? [String: Any] {
            paymentMethod = PaymentMethod(dict: dataCards)
        }
        
        self.init(payment: payment, paymentMethod: paymentMethod)
    }
    
}
