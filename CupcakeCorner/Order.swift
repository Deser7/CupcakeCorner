//
//  Order.swift
//  CupcakeCorner
//
//  Created by Наташа Спиридонова on 02.08.2025.
//

import Foundation

@Observable
final class Order {
    static let types = ["Vanilla", "Strawberry", "Chokolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequesEnabled = false {
        didSet {
            if specialRequesEnabled == false {
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
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        
        return true
    }
}
