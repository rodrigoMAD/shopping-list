//
//  ItemListView.swift
//  ShoppingList
//
//  Created by Rodrigo Esquivel on 21-02-25.
//

import Combine
import SwiftData
import SwiftUI

// MARK: - ParksList

struct ItemsList: View {

    // MARK: - Internal Properties
    
    @State var navigationPath = NavigationPath()

    // MARK: - Private Properties
    
    @Environment(\.injected) private var injected: DependencyInjectionContainer

    @State private var items: [DBModel.Item] = []
    @State private(set) var itemsState: Loadable<Void>
    @State private var routingState: Routing = .init()
    private var routingBinding: Binding<Routing> {
        $routingState.dispatched(to: injected.appState, \.routing.itemList)
    }
    
    // MARK: - Initializer
    
    init(state: Loadable<Void> = .notRequested) {
        self._itemsState = .init(initialValue: state)
    }
    
    // MARK: - View
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            content
                .navigationTitle("Items")
                .onReceive(routingUpdate) { self.routingState = $0 }
        }
    }
    
    // MARK: - ViewBuilder
    
    @ViewBuilder private var content: some View {
        switch itemsState {
        case .notRequested:
            defaultView()
        case .isLoading:
            loadingView()
        case .loaded:
            loadedView()
        case let .failed(error):
            failedView(error)
        }
        
    }
}

// MARK: - Loading Content

private extension ItemsList {
    func defaultView() -> some View {
        Text("").onAppear {
            if !items.isEmpty {
                itemsState = .loaded(())
            }
            loadItemsList()
        }
    }
    
    func loadingView() -> some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
    }
    
    func failedView(_ error: Error) -> some View {
        ErrorView(error: error, retryAction: {
            loadItemsList()
        })
    }
}

// MARK: - Displaying Content

@MainActor
private extension ItemsList {

    // MARK: - ListView
    
    @ViewBuilder
    func loadedView() -> some View {
        if items.isEmpty {
            Text("No items found")
                .font(.footnote)
        }
        List {
            ForEach(items) { item in
                ItemCell(item: item)
            }.onDelete(perform: deleteItem)
        }
        .refreshable { loadItemsList() }
        .toolbar { addButton }
        .sheet(isPresented: routingBinding.newItemSheetVisibility) { sheetView() }
        Text("Total: $\(routingBinding.subtotal.wrappedValue)")
            .font(.headline)
            .padding(.all)
    }
    
    // MARK: - ToolbarView
    
    private var addButton: some View {
        Button("Add", systemImage: "plus", action: showNewItemSheet)
    }
    
    // MARK: - SheetView

    @ViewBuilder
    private func sheetView() -> some View {
        Text("Add shopping item")
            .font(.largeTitle)
            .padding()
        
        VStack {
            HStack {
                Text("Name")
                    .font(.headline)
                TextField(
                    "Enter name",
                    text: routingBinding.newItemName
                )
            }
            HStack {
                Stepper {
                    Text("Quantity: \(routingBinding.newItemQuantity.wrappedValue)")
                        .font(.headline)
                } onIncrement: {
                    incrementStep()
                } onDecrement: {
                    decrementStep()
                }
            }
            HStack {
                Text("Price")
                    .font(.headline)
                TextField(
                    "Enter price",
                    value: routingBinding.newItemPrice,
                    formatter: NumberFormatter()
                )
            }
            Button("Add", action: addNewItem)
                .presentationDetents([.fraction(0.40)])
        }
        .padding()
        .multilineTextAlignment(.leading)
    }
    
    // MARK: - Private Methods
    
    private func incrementStep() {
        injected.appState[\.routing.itemList.newItemQuantity] += 1
    }
  
    private func decrementStep() {
        injected.appState[\.routing.itemList.newItemQuantity] -= 1
    }
}

// MARK: - State Updates

private extension ItemsList {
    
    // MARK: - Priate Properties
    
    var routingUpdate: AnyPublisher<Routing, Never> {
        injected.appState.updates(for: \.routing.itemList)
    }
    
    // MARK: - Private Methods
    
    func loadItemsList() {
        $itemsState.load {
            items = try await injected.interactors.items.fetchItems()
        }
        subtotal()
    }
    
    func addNewItem() {
        $itemsState.load {
            try await injected.interactors.items.store(
                item: .init(
                    id: UUID().uuidString,
                    name: injected.appState[\.routing.itemList.newItemName],
                    quantity: injected.appState[\.routing.itemList.newItemQuantity],
                    price: injected.appState[\.routing.itemList.newItemPrice] * injected.appState[\.routing.itemList.newItemQuantity]
                )
            )
            injected.appState[\.routing.itemList.newItemSheetVisibility] = false
            loadItemsList()
        }
    }
    
    func deleteItem(_ indexSet: IndexSet) {
        $itemsState.load {
            for index in indexSet {
                let item = items[index]
                try await injected.interactors.items.delete(item: item)
                loadItemsList()
            }
        }
    }
    
    func subtotal() {
        $itemsState.load {
            let subtotal = try await injected.interactors.items.subtotal()
            injected.appState[\.routing.itemList.subtotal] = subtotal
        }
    }
    
    func showNewItemSheet() {
        injected.appState[\.routing.itemList.newItemSheetVisibility] = true
        injected.appState[\.routing.itemList.newItemName] = ""
        injected.appState[\.routing.itemList.newItemQuantity] = 0
        injected.appState[\.routing.itemList.newItemPrice] = 0
    }
}
