//
//  BaseReponse.swift
//  datatrans_plugin_flutter
//
//  Created by Thien.Vu2 on 26/12/2023.
//

import Foundation

class BaseReponse {
    let error: String?
    let success: Bool
    let data: [String: Any?]?
    
    init(error: String? = nil,
         success: Bool = true,
         data: [String: Any?]?) {
        self.error = error
        self.success = success
        self.data = data
    }
    
    var toJson: String? {
        let dict: [String: Any?] = [
            "error": error,
            "success": success,
            "data": data
        ]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted) else {
            return nil
        }
        return String(data: jsonData, encoding: .ascii)
    }
}

extension BaseReponse {
    static var commonErrorResponse: BaseReponse {
        return BaseReponse(error: "Can not create transaction", success: false, data: nil)
    }
}
