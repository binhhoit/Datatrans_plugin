//
//  DatatransPluginTransaction.swift
//  DatatransPlugin
//
//  Created by Thien.Vu2 on 22/12/2023.
//

import Foundation
import Alamofire
import Datatrans

protocol DatatransPluginTransaction {
    var paymentCompletion: ((BaseReponse) -> Void)? { get set }
    
    func configure(params: TransactionInitializeParams)
    func payment(params: TransactionParams)
    func fastPayment(params: TransactionParams, savePaymentMethod: PaymentMethod)
}
