//
//  ItemsInteractorTests.swift
//  UnitTests
//
//  Created by Rodrigo Esquivel on 22-02-25.
//

import Testing
import SwiftUI
@testable import ShoppingList

@MainActor
@Suite class ItemsInteractorTests {
    
    // MARK: - Private Properties
    
    private let sut: ItemsInteractorImpl
    private let databaseRepository: ItemsDatabaseRepositoryMock
    
    // MARK: - Initializer
    
    init() {
        databaseRepository = ItemsDatabaseRepositoryMock()
        sut = ItemsInteractorImpl(
            databaseRepository: databaseRepository
        )
    }
    
    // MARK: - Tests
    
    @Test func fetchItems() async throws {
        // Given
        let expectedItems = [
            DBModel.Item(id: "foo-1", name: "foo-1-name", quantity: 1, price: 1),
            DBModel.Item(id: "foo-2", name: "foo-2-name", quantity: 1, price: 1),
            DBModel.Item(id: "foo-3", name: "foo-3-name", quantity: 1, price: 1)
        ]
        databaseRepository.actions = .init(expected: [.fetchItems])
        databaseRepository.fetchItemsResults = [.success(expectedItems)]
        
        // When
        let items = try await sut.fetchItems()
        
        // Verify
        #expect(items == expectedItems)
        databaseRepository.verify()
    }
    
    @Test func fetchItems_error() async throws {
        // Given
        databaseRepository.actions = .init(expected: [.fetchItems])
        let error = NSError.test
        databaseRepository.fetchItemsResults = [.failure(error)]
        
        // When / Then
        await #expect(throws: error) {
            try await sut.fetchItems()
        }
        
        // Verify
        databaseRepository.verify()
    }
    
    @Test func storeItem() async throws {
        // Given
        let expectedItem = DBModel.Item(id: "foo-4", name: "foo-4-name", quantity: 1, price: 1)
        databaseRepository.actions = .init(expected: [.store(expectedItem)])
        databaseRepository.storeItemResults = [.success(())]
        
        // When
        try await sut.store(item: expectedItem)
        
        // Verify
        databaseRepository.verify()
    }
    
    @Test func storeItem_error() async throws {
        // Given
        let expectedItem = DBModel.Item(id: "foo-4", name: "foo-4-name", quantity: 1, price: 1)
        databaseRepository.actions = .init(expected: [.store(expectedItem)])
        let error = NSError.test
        databaseRepository.storeItemResults = [.failure(error)]
        
        // When / Then
        await #expect(throws: error) {
            try await sut.store(item: expectedItem)
        }
        
        // Verify
        databaseRepository.verify()
    }
    
    @Test func deleteItem() async throws {
        // Given
        let expectedItem = DBModel.Item(id: "foo-4", name: "foo-4-name", quantity: 1, price: 1)
        databaseRepository.actions = .init(expected: [.delete(expectedItem)])
        databaseRepository.deleteItemResults = [.success(())]
        
        // When
        try await sut.delete(item: expectedItem)
        
        // Verify
        databaseRepository.verify()
    }
    
    @Test func deleteItem_error() async throws {
        // Given
        let expectedItem = DBModel.Item(id: "foo-4", name: "foo-4-name", quantity: 1, price: 1)
        databaseRepository.actions = .init(expected: [.delete(expectedItem)])
        let error = NSError.test
        databaseRepository.deleteItemResults = [.failure(error)]
        
        // When / Then
        await #expect(throws: error) {
            try await sut.delete(item: expectedItem)
        }
        
        // Verify
        databaseRepository.verify()
    }
    
    @Test func subtotal() async throws {
        // Given
        let expectedSubtotal = [
            DBModel.Item(id: "foo-1", name: "foo-1-name", quantity: 1, price: 1),
            DBModel.Item(id: "foo-2", name: "foo-2-name", quantity: 1, price: 1),
            DBModel.Item(id: "foo-3", name: "foo-3-name", quantity: 1, price: 1)
        ].map { $0.price }.reduce(0, +)
        databaseRepository.actions = .init(expected: [.subtotal])
        databaseRepository.subtotalResults = [.success(expectedSubtotal)]
        
        // When
        let subtotal = try await sut.subtotal()
        
        // Verify
        #expect(subtotal == expectedSubtotal)
        databaseRepository.verify()
    }
    
    @Test func subtotal_error() async throws {
        // Given
        databaseRepository.actions = .init(expected: [.subtotal])
        let error = NSError.test
        databaseRepository.subtotalResults = [.failure(error)]
        
        // When / Then
        await #expect(throws: error) {
            try await sut.subtotal()
        }
        
        // Verify
        databaseRepository.verify()
    }
}
