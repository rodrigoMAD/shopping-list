//
//  ItemsInteractor.swift
//  ShoppingList
//
//  Created by Rodrigo Esquivel on 21-02-25.
//

// MARK: - Interactor Interface

protocol ItemsInteractor {
    func fetchItems() async throws -> [DBModel.Item]
    func store(item: DBModel.Item) async throws
    func delete(item: DBModel.Item) async throws
    func subtotal() async throws -> Int
}

struct ItemsInteractorImpl: ItemsInteractor {

    // MARK: - Private Properties
    
    private let databaseRepository: ItemsDatabaseRepository
    
    // MARK: - Initializer
    
    init(databaseRepository: ItemsDatabaseRepository) {
        self.databaseRepository = databaseRepository
    }
    
    // MARK: - ItemsInteractor
    
    func fetchItems() async throws -> [DBModel.Item] {
        try await databaseRepository.fetchItems()
    }
    
    func store(item: DBModel.Item) async throws {
        try await databaseRepository.store(item: item)
    }
    
    func delete(item: DBModel.Item) async throws {
        try await databaseRepository.delete(item: item)
    }
    
    func subtotal() async throws -> Int {
        try await databaseRepository.subtotal()
    }
}

// MARK: Stub

struct StubItemsInteractor: ItemsInteractor {
    func fetchItems() async throws -> [DBModel.Item] { [] }
    func store(item: DBModel.Item) async throws { }
    func delete(item: DBModel.Item) async throws { }
    func subtotal() async throws -> Int { 0 }
}
