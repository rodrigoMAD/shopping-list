//
//  ModelContainerMock.swift
//  UnitTests
//
//  Created by Rodrigo Esquivel on 21-02-25.
//

import SwiftData
@testable import ShoppingList

// MARK: - ModelContainerMock

extension ModelContainer {
    static var mock: ModelContainer {
        try! appModelContainer(inMemoryOnly: true, isStub: false)
    }
}
