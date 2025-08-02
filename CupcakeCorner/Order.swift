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
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
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
}
