//
//  Store.swift
//  CupidAI
//
//  Created by Шарап Бамматов on 14.05.2023.
//

import Foundation

final class Store: ObservableObject {
    @Published var currentTab: Tab = .swipes
    
}

enum Tab: String, CaseIterable {
    case swipes, matches, messages, profile
}

