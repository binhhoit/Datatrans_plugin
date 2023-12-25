//
//  DatatransPluginTransaction.swift
//  DatatransPlugin
//
//  Created by Thien.Vu2 on 22/12/2023.
//

import Foundation
import Alamofire
import Datatrans

class DatatransPluginTransaction {
    static let instance = DatatransPluginTransaction()
    private init() {}

    private var merchantId: String = ""
    private var password: String = ""
    
    func configure(merchantId: String, password: String) {
        self.merchantId = merchantId
        self.password = password
    }
}
