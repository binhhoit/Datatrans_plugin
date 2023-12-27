//
//  TransactionInitalizationParams.swift
//  datatrans_plugin_flutter
//
//  Created by Thien.Vu2 on 25/12/2023.
//

import Foundation

class TransactionInitializeParams {
    private(set) var merchantId: String
    private(set) var password: String
    private(set) var isTesting: Bool
    private(set) var appCallbackScheme: String
    
    init(dict: [String: Any]) {
        self.merchantId = (dict["merchantId"] as? String) ?? ""
        self.password = (dict["password"] as? String) ?? ""
        self.isTesting = (dict["isTesting"] as? Bool) ?? false
        self.appCallbackScheme = (dict["appCallbackScheme"] as? String) ?? ""
    }
}
