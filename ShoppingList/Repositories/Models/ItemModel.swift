//
//  ItemModel.swift
//  ShoppingList
//
//  Created by Rodrigo Esquivel on 21-02-25.
//

import Foundation
import SwiftData

// MARK: - Database Model

extension DBModel {
    @Model final class Item: Equatable {
        
        @Attribute(.unique) var id: String
        var name: String
        var quantity: Int
        var price: Int
        
        init(id: String, name: String, quantity: Int, price: Int) {
            self.id = id
            self.name = name
            self.quantity = quantity
            self.price = price
        }
        
        // MARK: - Equatable
        
        static func == (lhs: Item, rhs: Item) -> Bool {
            lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.quantity == rhs.quantity &&
            lhs.price == rhs.price
        }
    }
}
