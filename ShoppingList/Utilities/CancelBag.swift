//
//  CancelBag.swift
//  ShoppingList
//
//  Created by Rodrigo Esquivel on 22-02-25.
//

import Combine

// MARK: - CancelBag

final class CancelBag {

    // MARK: - Fileprivate Properties

    fileprivate(set) var subscriptions = [any Cancellable]()
    
    // MARK: - Private Properties

    private let equalToAny: Bool
    
    // MARK: - Initializer
    
    init(equalToAny: Bool = false) {
        self.equalToAny = equalToAny
    }
    
    // MARK: - Internal Methods
    
    func cancel() {
        subscriptions.removeAll()
    }
    
    func isEqual(to other: CancelBag) -> Bool {
        return other === self || other.equalToAny || self.equalToAny
    }
}

// MARK: - Cancellable

extension Cancellable {
    
    func store(in cancelBag: CancelBag) {
        cancelBag.subscriptions.append(self)
    }
}

// MARK: - Task

extension Task: @retroactive Cancellable { }
