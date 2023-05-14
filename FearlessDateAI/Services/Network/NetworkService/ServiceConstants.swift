//
//  ServiceConstants.swift
//  FearlessDateAI
//
//  Created by Денис Сторожик on 14.05.2023.
//

import Foundation

enum ServiceConstants {
    
    static let baseUrl = URL(string: APIURL.develop.rawValue)
    
    static let requestTimeout: TimeInterval = 60
    static let resourceTimeout: TimeInterval = 60
    static let validCodes = (200 ..< 300)
}

enum APIURL: String {
    case develop = "http://34.168.23.155:8000/"
}
