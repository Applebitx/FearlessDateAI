//
//  HTTPMethod.swift
//  FearlessDateAI
//
//  Created by Денис Сторожик on 14.05.2023.
//

import Foundation

public enum RequestType: String {
    case connect = "CONNECT"
    case delete = "DELETE"
    case get = "GET"
    case head = "HEAD"
    case options = "OPTIONS"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
    case query = "QUERY"
    case trace = "TRACE"
}
