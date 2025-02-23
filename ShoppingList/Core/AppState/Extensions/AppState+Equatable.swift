//
//  AppState+Equatable.swift
//  ShoppingList
//
//  Created by Rodrigo Esquivel on 21-02-25.
//

// MARK: - Equatable

extension AppState: Equatable {
    static func == (lhs: AppState, rhs: AppState) -> Bool {
        lhs.routing == rhs.routing
    }
}
