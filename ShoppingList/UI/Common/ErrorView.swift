//
//  ErrorView.swift
//  ShoppingList
//
//  Created by Rodrigo Esquivel on 22-02-25.
//

import SwiftUI

struct ErrorView: View {
    let error: Error
    let retryAction: () -> Void
    
    var body: some View {
        VStack {
            Text("An Error Occured")
                .font(.title)
            Text(error.localizedDescription)
                .font(.callout)
                .multilineTextAlignment(.center)
                .padding(.bottom, 40).padding()
            Button(action: retryAction, label: { Text("Retry").bold() })
        }
    }
}

#Preview {
    ErrorView(
        error: NSError(
            domain: "",
            code: 0,
            userInfo: [
                NSLocalizedDescriptionKey: "Something went wrong"
            ]
        ),
        retryAction: { }
    )
}
