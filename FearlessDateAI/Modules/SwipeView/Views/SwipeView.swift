//
//  SwipeView.swift
//  CupidAI
//
//  Created by Шарап Бамматов on 14.05.2023.
//

import SwiftUI

struct SwipeView: View {
    @StateObject var vm = SwipeViewModel()
    
    var body: some View {
        VStack {
            Text("Discover")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.redColor)
            
            ZStack {
                if let users = vm.displayingUsers {
                    
                    if users.isEmpty {
                        Text("Come back later we can find more matches for you!")
                            .font(.caption)
                            .foregroundColor(.gray)
                    } else {
                        ForEach(users.reversed()) { user in
                            SwipeCardView(user: user)
                                .environmentObject(vm)
                        }
                    }
                    
                }
            }
            .padding()
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    func doSwipe(rightSwipe: Bool = false) {
        guard let first = vm.displayingUsers?.first else {
            return
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("ACTIONFROMBUTTON"), object: nil, userInfo: [
            "id": first.id as Any,
            "rightSwipe": rightSwipe
        ])
    }
}

struct SwipeView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(Store())
    }
}
