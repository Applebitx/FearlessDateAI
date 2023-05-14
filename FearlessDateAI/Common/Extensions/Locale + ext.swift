//
//  Locale + ext.swift
//  FearlessDateAI
//
//  Created by Денис Сторожик on 14.05.2023.
//

import Foundation

public extension Locale {
    var acceptLanguage: String {
        identifier.replacingOccurrences(of: "_", with: "-")
    }
}
