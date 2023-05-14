//
//  Endpoint.swift
//  FearlessDateAI
//
//  Created by Денис Сторожик on 14.05.2023.
//

import Foundation

public protocol Endpoint {
    var path: String { get }
    var requestType: RequestType { get }
    var header: [String: String]? { get }
    var parameters: [String: Any]? { get }
    var url: URL? { get }
}

extension Endpoint {
    var url: URL? {
        return URL(string: "base url")}
}
