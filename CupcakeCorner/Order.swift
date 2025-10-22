//
//  Order.swift
//  CupcakeCorner
//
//  Created by Наташа Спиридонова on 02.08.2025.
//

import Foundation

@Observable
final class Order: Encodable {
    
    static let types = [
        "Ванильный",
        "Клубничный",
        "Шоколадный",
        "Радужный"
    ]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = "" {
        didSet {
            UserDefaults.standard.set(name, forKey: "deliveryName")
        }
    }
    var streetAddress = "" {
        didSet {
            UserDefaults.standard.set(streetAddress, forKey: "deliveryStreet")
        }
    }
    var city = "" {
        didSet {
            UserDefaults.standard.set(city, forKey: "deliveryCity")
        }
    }
    var zip = "" {
        didSet {
            UserDefaults.standard.set(zip, forKey: "deliveryZip")
        }
    }
    
    var isValidAddress: Bool {
        [name, streetAddress, city, zip].allSatisfy { hasRealContent($0) }
    }
    
    var cost: Decimal {
        var cost = Decimal(quantity * 2)
        
        cost += Decimal(type) / 2
        
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        
        return cost * 100
    }
    
    private func hasRealContent(_ string: String) -> Bool {
        let trimmed = string.trimmingCharacters(in: .whitespacesAndNewlines)
        return !trimmed.isEmpty
    }
    
    func loadSavedAddress() {
        name = UserDefaults.standard.string(forKey: "deliveryName") ?? ""
        streetAddress = UserDefaults.standard.string(forKey: "deliveryStreet") ?? ""
        city = UserDefaults.standard.string(forKey: "deliveryCity") ?? ""
        zip = UserDefaults.standard.string(forKey: "deliveryZip") ?? ""
    }
}
