//
//  CupidAIApp.swift
//  CupidAI
//
//  Created by Денис Сторожик on 13.05.2023.
//

import SwiftUI

@main
struct CupidAIApp: App {
    @StateObject private var store = Store()
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(store)
        }
    }
}
