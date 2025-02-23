//
//  ItemsList+Routing.swift
//  ShoppingList
//
//  Created by Rodrigo Esquivel on 21-02-25.
//

// MARK: - Routing

extension ItemsList {
    struct Routing: Equatable {
        var newItemSheetVisibility: Bool = false
        var newItemName: String = ""
        var newItemQuantity = 0
        var newItemPrice = 0
        var subtotal = 0
    }
}
