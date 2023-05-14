//
//  Data+ext.swift
//  FearlessDateAI
//
//  Created by Денис Сторожик on 14.05.2023.
//

import Foundation

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
    
    func decode<T: Codable>(model: T.Type) -> T? {
        return try? JSONDecoder().decode(model.self, from: self)
    }
    
    // NSString gives us a nice sanitized debugDescription
    // How to use:
    // let str = "{\"foo\": \"bar\"}".data(using: .utf8)!.prettyPrintedJSONString!
    // debugPrint(str)
    var prettyPrintedJSONString: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        else {
            return nil
        }
        
        return prettyPrintedString
    }
}
