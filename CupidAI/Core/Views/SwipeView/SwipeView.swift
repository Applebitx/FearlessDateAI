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
        .padding(.vertical)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct SwipeView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeView()
    }
}
