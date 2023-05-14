//
//  RequestBuilder.swift
//  FearlessDateAI
//
//  Created by Денис Сторожик on 14.05.2023.
//

import Foundation

final class BodyAdapter {
    
    static func createJSONBody(with data: [String: Any]) throws -> Data? {
        let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
        return jsonData
    }
       
    static func createBody(with parameters: [String: Any]? = nil, files: [(String, URL)] = [], boundary: String) throws -> Data? {
        var body = Data()
        
        var params = parameters ?? [:]
        
        params.forEach { (key, value) in
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.append("\(value)\r\n")
        }
        
        for (fileParamKey, url) in files {
            let filename = url.lastPathComponent
            let data = try Data(contentsOf: url)
            
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(fileParamKey)\"; filename=\"\(filename)\"\r\n")
            body.append("Content-Type: \(url.mimeType)\r\n\r\n")
            body.append(data)
            body.append("\r\n")
        }
        
        body.append("--\(boundary)--\r\n")
        return body
    }
    
    static func generateBoundaryString() -> String {
           return "Boundary-" + UUID().uuidString
       }
}

