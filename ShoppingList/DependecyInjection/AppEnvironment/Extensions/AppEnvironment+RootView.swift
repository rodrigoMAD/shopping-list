//
//  AppEnvironment+RootView.swift
//  ShoppingList
//
//  Created by Rodrigo Esquivel on 21-02-25.
//

import SwiftUI

// MARK: - RootView

extension AppEnvironment {
    
    // MARK: - View

    var rootView: some View {
        VStack {
            if isRunningTests {
                Text("Running unit tests")
            } else {
                ItemsList()
                    .modifier(RootViewAppearance())
                    .modelContainer(modelContainer)
                    .inject(dependencyInjectionContainer)
                if modelContainer.isStub {
                    Text("⚠️ There is an issue with local database")
                        .font(.caption2)
                }
            }
        }
    }
}

