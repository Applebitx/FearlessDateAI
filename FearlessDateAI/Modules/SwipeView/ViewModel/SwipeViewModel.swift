//
//  SwipeViewModel.swift
//  CupidAI
//
//  Created by Шарап Бамматов on 14.05.2023.
//

import Foundation

final class SwipeViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var displayingUsers: [User]?
    @Published var fullDetailInfo: Bool = false
    
    init() {
        users = User.fetchMocks
        
        displayingUsers = users
    }
    
    func getIndex(user: User) -> Int {
        let index = displayingUsers?.firstIndex(where: { currentUser in
            return user.id == currentUser.id
        }) ?? 00
        
        return index
    }
    
    func leftSwipe() {
        print("leftswipe")
        fullDetailInfo = false
    }
    
    func rightSwipe() {
        print("rightSwipe")
        fullDetailInfo = false
    }
    
}
