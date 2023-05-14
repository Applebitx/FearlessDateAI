//
//  SwipeCardView.swift
//  CupidAI
//
//  Created by Шарап Бамматов on 14.05.2023.
//

import SwiftUI

struct SwipeCardView: View {
    @EnvironmentObject var vm: SwipeViewModel
    var user: User
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            ZStack {
                Image(user.profilePicture ?? "girl1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: size.width, height: size.height)
                    .cornerRadius(15)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
}

struct SwipeCardView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(Store())
    }
}
