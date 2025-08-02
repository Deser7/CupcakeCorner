//
//  NetworkServices.swift
//  CupcakeCorner
//
//  Created by Наташа Спиридонова on 02.08.2025.
//

import Foundation

final class NetworkServices {
    static let shared = NetworkServices()
    
    private init() {}
    
    let currencyCode = Locale.current.currency?.identifier ?? "RUB"
    let imageURL = URL(string: "https://hws.dev/img/cupcakes@3x.jpg")!
    let requestURL = URL(string: "https://reqres.in/api/cupcakes")!
    
    var confirmationMessage = ""
    var showConfirmation = false
}
