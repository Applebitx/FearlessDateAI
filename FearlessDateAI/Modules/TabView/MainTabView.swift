//
//  MainTabView.swift
//  CupidAI
//
//  Created by Шарап Бамматов on 13.05.2023.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject private var store: Store
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(named: "TabBarBackgroundColor")
        }
    
    var body: some View {
        TabView(selection: $store.currentTab) {
            SwipeView()
                .tabItem {
                    Image(systemName: "rectangle.portrait.on.rectangle.portrait.angled.fill")
                    
                    Text("Swipes")
                }
                .tag(Tab.swipes)
            
            MatchesView()
                .tabItem {
                    Image(systemName: "heart")
                    
                    Text("Matches")
                }
                .tag(Tab.matches)
            
            Text("Messages")
                .tabItem {
                    Image(systemName: "text.bubble.fill")
                    
                    Text("Messages")
                }
                .tag(Tab.messages)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    
                    Text("Account")
                }
                .tag(Tab.profile)
        }
        .accentColor(.redColor)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(Store())
    }
}
