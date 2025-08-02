//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Наташа Спиридонова on 02.08.2025.
//

import SwiftUI

// MARK: - Response Structure
struct OrderResponse: Codable {
    let type: Int
    let quantity: Int
}

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
                
                Text("Итоговая стоимость заказа \(order.cost, format: .currency(code: networkService.currencyCode))")
                    .font(.title)
                    .multilineTextAlignment(.center)
                
                Button("Оформить заказ") {
                    Task {
                        await placeOrder()
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
    
    // MARK: - Network Functions
    func placeOrder() async {
        guard let encoder = try? JSONEncoder().encode(order) else {
            errorMessage = "Ошибка кодирования заказа"
            showError = true
            return
        }
        
        var request = URLRequest(url: networkService.requestURL)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoder)
            
            let decodedOrder = try JSONDecoder().decode(OrderResponse.self, from: data)
            confirmationMessage = "Ваш заказ для \(decodedOrder.quantity)x\(Order.types[decodedOrder.type].lowercased()) кексы уже в пути!"
            showConfirmation = true
        } catch {
            errorMessage = "Ошибка: \(error.localizedDescription)"
            showError = true
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
