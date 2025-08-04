//
//  AdressView.swift
//  CupcakeCorner
//
//  Created by Наташа Спиридонова on 02.08.2025.
//

import SwiftUI

struct AddressView: View {
    @Binding var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Имя", text: $order.name)
                TextField("Адрес", text: $order.streetAddress)
                TextField("Город", text: $order.city)
                TextField("Индекс", text: $order.zip)
            }
            
            Section {
                NavigationLink("Оформить заказ") {
                    CheckoutView(order: order)
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Детали доставки")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            order.loadSavedAddress()
        }
    }
}

#Preview {
    AddressView(order: .constant(Order()))
}
