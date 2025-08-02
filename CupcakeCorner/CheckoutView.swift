//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Наташа Спиридонова on 02.08.2025.
//

import SwiftUI

struct CheckoutView: View {
    let order: Order
    let networkService = NetworkServices.shared
    
    @State private var confirmationMessage = ""
    @State private var showConfirmation = false
    @State private var errorMessage = ""
    @State private var showError = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: networkService.imageURL, scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Стоимость заказа \(order.cost, format: .currency(code: networkService.currencyCode))")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Button("Оформить заказ") {
                    Task {
                        let result = await networkService.placeOrder(with: order)
                        switch result {
                        case .success(let message):
                            confirmationMessage = message
                            showConfirmation = true
                        case .failure(let error):
                            errorMessage = "Ошибка \(error.localizedDescription)"
                            showError = true
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Итог")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Спасибо!", isPresented: $showConfirmation) {
            Button("OK") {}
        } message: {
            Text(confirmationMessage)
        }
        .alert("Ошибка", isPresented: $showError) {
            Button("OK") {}
        } message: {
            Text(errorMessage)
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
