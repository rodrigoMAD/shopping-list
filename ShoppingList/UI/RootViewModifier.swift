//
//  RootViewModifier.swift
//  ShoppingList
//
//  Created by Rodrigo Esquivel on 21-02-25.
//

import SwiftUI

// MARK: - RootViewAppearance

struct RootViewAppearance: ViewModifier {
    @Environment(\.injected) private var injected: DependencyInjectionContainer
    
    func body(content: Content) -> some View {
        content
            .ignoresSafeArea()
    }
}
