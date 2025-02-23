//
//  Loadable.swift
//  ShoppingList
//
//  Created by Rodrigo Esquivel on 22-02-25.
//

import Foundation
import SwiftUI

// MARK: - Typealias

typealias LoadableSubject<T> = Binding<Loadable<T>>

// MARK: - Loadable

enum Loadable<T> {

    case notRequested
    case isLoading(last: T?, cancelBag: CancelBag)
    case loaded(T)
    case failed(Error)
    
    // MARK: - Value

    var value: T? {
        switch self {
        case let .loaded(value): return value
        case let .isLoading(last, _): return last
        default: return nil
        }
    }
    
    // MARK: - Error

    var error: Error? {
        switch self {
        case let .failed(error): return error
        default: return nil
        }
    }
}

extension Loadable {
    
    mutating func setIsLoading(cancelBag: CancelBag) {
        self = .isLoading(last: value, cancelBag: cancelBag)
    }
}

// MARK: - LoadableSubject

extension LoadableSubject {
    func load<T>(_ resource: @escaping () async throws -> T) where Value == Loadable<T> {
        let cancelBag = CancelBag()
        wrappedValue.setIsLoading(cancelBag: cancelBag)
        let task = Task {
            do {
                wrappedValue = .loaded(try await resource())
            } catch {
                wrappedValue = .failed(error)
            }
        }
        task.store(in: cancelBag)
    }
}
