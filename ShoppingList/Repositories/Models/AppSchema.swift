//
//  AppSchema.swift
//  ShoppingList
//
//  Created by Rodrigo Esquivel on 21-02-25.
//

import SwiftData

// MARK: - AppSchema

extension Schema {
    private static var actualVersion: Schema.Version = Version(1, 0, 0)

    static var appSchema: Schema {
        Schema([
            DBModel.Item.self
        ], version: actualVersion)
    }
}

// MARK: - DB Model

enum DBModel { }
