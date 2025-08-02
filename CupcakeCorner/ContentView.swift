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
                    Picker("Выберите Ваш кекс", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Количество кексов \(order.quantity)", value: $order.quantity)
                }
                
                Section {
                    Toggle("Добавить ингридиенты?", isOn: $order.specialRequesEnabled.animation())
                    
                    if order.specialRequesEnabled {
                        Toggle("Глазурь", isOn: $order.extraFrosting)
                        
                        Toggle("Посыпка", isOn: $order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink("Детали доставки") {
                        AdressView(order: $order)
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

#Preview {
    ContentView()
}
