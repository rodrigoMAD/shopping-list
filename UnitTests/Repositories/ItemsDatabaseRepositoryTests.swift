//
//  ItemsDatabaseRepositoryTests.swift
//  UnitTests
//
//  Created by Rodrigo Esquivel on 21-02-25.
//

import Foundation
import Testing
import SwiftData
@testable import ShoppingList

@MainActor
@Suite struct ItemsDatabaseRepositoryTests {
    
    // MARK: - Private Properties
    
    private let container: ModelContainer
    private let sut: ItemsDatabaseRepository

    // MARK: - Initializer
    
    init() {
        container = .mock
        sut = ItemsDatabaseRepositoryImpl(modelContainer: container)
    }
    
    // MARK: - Tests
    
    @Test func fetchItems() async throws {
        // Given
        let item = DBModel.Item(id: UUID().uuidString, name: "name", quantity: 1, price: 1)
        try await sut.store(item: item)
        
        // When
        let items = try await sut.fetchItems()
        
        // Then / Verify
        let results = try container.mainContext
            .fetch(FetchDescriptor<DBModel.Item>())
        #expect(results == items)
    }
    
    @Test func storeItem() async throws {
        // Given
        let item = DBModel.Item(id: UUID().uuidString, name: "name", quantity: 1, price: 1)
        
        // When
        try await sut.store(item: item)
        
        // Then / Verify
        let results = try container.mainContext
            .fetch(FetchDescriptor<DBModel.Item>())
        #expect(results[0] == item)
    }
    
    @Test func deleteItem() async throws {
        // Given
        let item = DBModel.Item(id: UUID().uuidString, name: "name", quantity: 1, price: 1)
        
        // When
        try await sut.delete(item: item)
        
        // Then / Verify
        let results = try container.mainContext
            .fetch(FetchDescriptor<DBModel.Item>())
        #expect(results.count == .zero)
    }
    
    @Test func subtotal() async throws {
        // Given
        let item = DBModel.Item(id: UUID().uuidString, name: "name", quantity: 1, price: 1)
        try await sut.store(item: item)
        
        // When
        let subtotal = try await sut.subtotal()
        
        // Then / Verify
        let results = try container.mainContext
            .fetch(FetchDescriptor<DBModel.Item>())
        #expect(results.map { $0.price }.reduce(0, +) == subtotal)
    }
}
