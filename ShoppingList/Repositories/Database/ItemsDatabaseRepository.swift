//
//  ItemsDatabaseRepository.swift
//  ShoppingList
//
//  Created by Rodrigo Esquivel on 21-02-25.
//

import SwiftData
import Foundation

// MARK: - Repository Interface

protocol ItemsDatabaseRepository {
    @MainActor
    func fetchItems() async throws -> [DBModel.Item]
    func store(item: DBModel.Item) async throws
    func delete(item: DBModel.Item) async throws
    func subtotal() async throws -> Int
}

// MARK: - Repository Implementaion

extension ItemsDatabaseRepositoryImpl: ItemsDatabaseRepository {
    
    // MARK: - ItemsDatabaseRepository

    func fetchItems() async throws -> [DBModel.Item] {
        try modelContext.fetch(FetchDescriptor<DBModel.Item>())
    }
    
    func store(item: DBModel.Item) async throws {
        try modelContext.transaction {
            modelContext.insert(item)
        }
    }
    
    func delete(item: DBModel.Item) async throws {
        try modelContext.transaction {
            modelContext.delete(item)
        }
    }
    
    func subtotal() async throws -> Int {
        let items = try modelContext.fetch(FetchDescriptor<DBModel.Item>())
        return items.map { $0.price }.reduce(0, +)
    }
}
