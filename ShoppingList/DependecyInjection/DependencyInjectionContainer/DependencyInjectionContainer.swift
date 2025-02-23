//
//  DependencyInjectionContainer.swift
//  ShoppingList
//
//  Created by Rodrigo Esquivel on 21-02-25.
//

struct DependencyInjectionContainer {
    
    // MARK: - Internal Properties

    let appState: Store<AppState>
    let interactors: Interactors
    
    // MARK: - Initializer
    
    init(appState: Store<AppState>, interactors: Interactors) {
        self.appState = appState
        self.interactors = interactors
    }
    
    // MARK: - Convinience Initializer
    
    init(appState: AppState, interactors: Interactors) {
        self.init(appState: Store<AppState>(appState), interactors: interactors)
    }
}

// MARK: - Stub

extension DependencyInjectionContainer {
    struct Interactors {
        let items: ItemsInteractor

        static var stub: Self {
            .init(items: StubItemsInteractor())
        }
    }
}
