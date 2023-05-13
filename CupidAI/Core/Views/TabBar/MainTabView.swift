//
//  MainTabView.swift
//  CupidAI
//
//  Created by Шарап Бамматов on 13.05.2023.
//

import SwiftUI

struct MainTabView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor(named: "TabBarBackgroundColor")
        }
    
    var body: some View {
        TabView {
            Text("SwipeView")
                .tabItem {
                    Image(systemName: "rectangle.portrait.on.rectangle.portrait.angled.fill")
                    
                    Text("Swipes")
                }
            
            Text("Matches")
                .tabItem {
                    Image(systemName: "heart")
                    
                    Text("Matches")
                }
            
            Text("Messages")
                .tabItem {
                    Image(systemName: "text.bubble.fill")
                    
                    Text("Messages")
                }
            
            Text("Profile")
                .tabItem {
                    Image(systemName: "person")
                    
                    Text("Account")
                }
        }
        .accentColor(.redColor)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
