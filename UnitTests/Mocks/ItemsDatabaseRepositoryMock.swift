//
//  ItemsDatabaseRepositoryMock.swift
//  UnitTests
//
//  Created by Rodrigo Esquivel on 22-02-25.
//

import SwiftData
@testable import ShoppingList

final class ItemsDatabaseRepositoryMock: Mock, ItemsDatabaseRepository {
    
    // MARK: - Mock

    enum Action: Equatable {
        case fetchItems
        case store(DBModel.Item)
        case delete(DBModel.Item)
        case subtotal
    }
    
    var actions = MockActions<Action>(expected: [])
    
    // MARK: - Results
    
    var fetchItemsResults: [Result<[DBModel.Item], Error>] = []
    var storeItemResults: [Result<Void, Error>] = []
    var deleteItemResults: [Result<Void, Error>] = []
    var subtotalResults: [Result<Int, Error>] = []
    
    // MARK: - Database
    
    func fetchItems() async throws -> [DBModel.Item] {
        register(.fetchItems)
        guard !fetchItemsResults.isEmpty else { throw MockError.valueNotSet }
        return try fetchItemsResults.removeFirst().get()
    }
    
    func store(item: DBModel.Item) async throws {
        register(.store(item))
        guard !storeItemResults.isEmpty else { throw MockError.valueNotSet }
        try storeItemResults.removeFirst().get()
    }
    
    func delete(item: DBModel.Item) async throws {
        register(.delete(item))
        guard !deleteItemResults.isEmpty else { throw MockError.valueNotSet }
        try deleteItemResults.removeFirst().get()
    }
    
    func subtotal() async throws -> Int {
        register(.subtotal)
        guard !subtotalResults.isEmpty else { throw MockError.valueNotSet }
        return try subtotalResults.removeFirst().get()
    }
}

// MARK: - ModelContainer

extension ModelContainer {
    static var mcok: ModelContainer {
        try! appModelContainer(inMemoryOnly: true, isStub: false)
    }
}
