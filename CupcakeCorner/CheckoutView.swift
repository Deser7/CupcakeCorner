//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Наташа Спиридонова on 02.08.2025.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: order.url, scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Итоговая стоимость заказа \(order.cost, format: .currency(code: order.currencyCode))")
                    .font(.title)
                    .multilineTextAlignment(.center)
                
                Button("Оформить заказ", action: {})
                    .padding()
            }
        }
        .navigationTitle("Итог")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
    }
}

#Preview {
    CheckoutView(order: Order())
}
