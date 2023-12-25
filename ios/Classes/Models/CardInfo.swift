//
//  CardInfo.swift
//  datatrans_plugin_flutter
//
//  Created by Thien.Vu2 on 25/12/2023.
//

import Foundation

class CardInfo: NSObject {
    private(set) var alias: String
    private(set) var expiryMonth: Int
    private(set) var expiryYear: Int
    
    init(alias: String, expiryMonth: Int, expiryYear: Int) {
        self.alias = alias
        self.expiryMonth = expiryMonth
        self.expiryYear = expiryYear
    }
    
    convenience init(dict: [String: Any]) {
        let alias = (dict["alias"] as? String) ?? ""
        let expiryMonth = (dict["expiryMonth"] as? Int) ?? 0
        let expiryYear = (dict["expiryYear"] as? Int) ?? 0
        
        self.init(alias: alias,
                  expiryMonth: expiryMonth,
                  expiryYear: expiryYear)
    }
    
    func toParams() -> [String: Any] {
        return [
            "alias": alias,
            "expiryMonth": expiryMonth,
            "expiryYear": expiryYear
        ]
    }
}
