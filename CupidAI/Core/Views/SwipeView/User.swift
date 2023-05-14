//
//  User.swift
//  CupidAI
//
//  Created by Шарап Бамматов on 14.05.2023.
//

import Foundation

struct User: Identifiable, Codable {
    let id, firstName, lastName, birthday: String?
    let gender, interests: String?
    let displayGender: Int?
    let passion, email, profilePicture, chatStatus: String?
    let userStatus: Int?
    let userRole, phoneNumber: String?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case birthday, gender, interests
        case displayGender = "display_gender"
        case passion, email
        case profilePicture = "profile_picture"
        case chatStatus = "chat_status"
        case userStatus = "user_status"
        case userRole = "user_role"
        case phoneNumber = "phone_number"
    }
    
    static var fetchMock: User {
        User(id: "1", firstName: "Shur", lastName: "Bamm", birthday: "03.03.02", gender: nil, interests: nil, displayGender: nil, passion: nil, email: nil, profilePicture: nil, chatStatus: nil, userStatus: nil, userRole: nil, phoneNumber: nil)
    }
    
    static var fetchMocks: [User] {
        [User(id: "1", firstName: "Shur", lastName: "Bamm", birthday: "03.03.02", gender: nil, interests: nil, displayGender: nil, passion: nil, email: nil, profilePicture: "girl1", chatStatus: nil, userStatus: nil, userRole: nil, phoneNumber: nil),
         User(id: "2", firstName: "Shur22", lastName: "Bamm", birthday: "03.03.02", gender: nil, interests: nil, displayGender: nil, passion: nil, email: nil, profilePicture: "girl2", chatStatus: nil, userStatus: nil, userRole: nil, phoneNumber: nil),
         User(id: "3", firstName: "Shur33", lastName: "Bamm", birthday: "03.03.02", gender: nil, interests: nil, displayGender: nil, passion: nil, email: nil, profilePicture: "girl3", chatStatus: nil, userStatus: nil, userRole: nil, phoneNumber: nil)]
    }
}
