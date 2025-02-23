//
//  AppState+ViewRouting.swift
//  ShoppingList
//
//  Created by Rodrigo Esquivel on 21-02-25.
//

// MARK: - ViewRouting

extension AppState {
    struct ViewRouting: Equatable {
        var itemList = ItemsList.Routing()
    }
}
