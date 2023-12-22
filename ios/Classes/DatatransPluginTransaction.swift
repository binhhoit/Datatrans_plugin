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
    private let merchantId: String
    private let password: String
    
    init(merchantId: String, password: String) {
        self.merchantId = merchantId
        self.password = password
    }
}
