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
        }
        .navigationTitle("Детали доставки")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddressView(order: .constant(Order()))
}
