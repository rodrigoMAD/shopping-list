//
//  EnvironmentValues+Injected.swift
//  ShoppingList
//
//  Created by Rodrigo Esquivel on 21-02-25.
//

import SwiftUI

extension EnvironmentValues {
    @Entry var injected: DependencyInjectionContainer = DependencyInjectionContainer(appState: AppState(), interactors: .stub)
}
