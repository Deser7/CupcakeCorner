//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Наташа Спиридонова on 02.08.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var order = Order()

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Выберите свой кекс", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }

                    Stepper("Количество кексов: \(order.quantity)", value: $order.quantity, in: 3...20)
                }

                Section {
                    Toggle("Добавить ингредиенты?", isOn: $order.specialRequestEnabled)

                    if order.specialRequestEnabled {
                        Toggle("Глазурь", isOn: $order.extraFrosting)

                        Toggle("Посыпка", isOn: $order.addSprinkles)
                    }
                }

                Section {
                    NavigationLink("Детали доставки") {
                        AddressView(order: $order)
                    }
                }
            }
            .navigationTitle("Вкусные кексы")
        }
    }
}

#Preview {
    ContentView()
}
