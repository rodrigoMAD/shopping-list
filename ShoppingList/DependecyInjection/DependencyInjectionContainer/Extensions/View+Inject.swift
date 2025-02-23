//
//  View+Inject.swift
//  ShoppingList
//
//  Created by Rodrigo Esquivel on 21-02-25.
//

import SwiftUI

extension View {
    func inject(_ container: DependencyInjectionContainer) -> some View {
        return self
            .environment(\.injected, container)
    }
}
