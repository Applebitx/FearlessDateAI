//
//  AuthEndpoint.swift
//  FearlessDateAI
//
//  Created by Денис Сторожик on 14.05.2023.
//

import Foundation

enum UserServiceEndpoint: Endpoint {
    
    case register(user: User)
    case logIn(login: String, password: String)

    var path: String {
        switch self {
        case .register:
            return ""//API
        case .logIn:
            return ""//API
        }
    }

    var requestType: RequestType {
        switch self {
        case .register, .logIn:
            return .post
        }
    }

    var header: [String : String]? {
        switch self {
        case .register, .logIn:
            return ["Content-Type":"application/json"]
        }
    }

    var parameters: [String: Any]? {
        switch self {
        case .register(let user):
            return ["first_name" :  [],
                    "last_name" : [],
                    "birthday" : [],
                    "interests" : [],
                    "display_gender" : [],
                    "passion" : [],
                    "email" : [],
                    "password" : [],
                    "profile_picture" : [] ]
        case .logIn(let login, let password):
            return ["email" : login,
                    "password" : password]
        }
    }

    var jsonObject: Encodable? {
        return nil
    }
}
