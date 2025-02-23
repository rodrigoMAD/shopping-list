//
//  ItemCell.swift
//  ShoppingList
//
//  Created by Rodrigo Esquivel on 21-02-25.
//

import SwiftUI

struct ItemCell: View {
    
    // MARK: - Internal Properties

    let item: DBModel.Item
    
    // MARK: - View

    var body: some View {
        VStack(alignment: .leading) {
            Text(item.name)
                .font(.headline)
            Divider()
            HStack {
                Text("Quantity: ")
                    .font(.caption)
                Text("\(item.quantity)")
                    .font(.caption)
                Text("Price: ")
                    .font(.caption)
                Text("$\(item.price)")
                    .font(.caption)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 60, alignment: .leading)
    }
}
