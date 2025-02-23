//
//  AppEnvironment.swift
//  ShoppingList
//
//  Created by Rodrigo Esquivel on 21-02-25.
//

import Foundation
import SwiftData

// MARK: - App Environment

@MainActor
struct AppEnvironment {
    let isRunningTests: Bool
    let dependencyInjectionContainer: DependencyInjectionContainer
    let modelContainer: ModelContainer
}

// MARK: - Composition Pattern

extension AppEnvironment {
    
    // MARK: - Internal Static Methods
    
    static func bootstrap() -> AppEnvironment {
        let appState = Store<AppState>(AppState())
        let modelContainer = configuredModelContainer()
        let databaseRepository = ItemsDatabaseRepositoryImpl(modelContainer: modelContainer)
        let itemsInteractor = ItemsInteractorImpl(databaseRepository: databaseRepository)
        let interactors = DependencyInjectionContainer.Interactors(items: itemsInteractor)
        let dependencyInjectionContainer = DependencyInjectionContainer(
            appState: appState,
            interactors: interactors
        )
        return AppEnvironment(
            isRunningTests: false,
            dependencyInjectionContainer: dependencyInjectionContainer,
            modelContainer: modelContainer
        )
    }
    
    // MARK: - Private Static Methods
    
    private static func configuredModelContainer() -> ModelContainer {
        do {
            return try ModelContainer.appModelContainer()
        } catch {
            return ModelContainer.stub
        }
    }
}
