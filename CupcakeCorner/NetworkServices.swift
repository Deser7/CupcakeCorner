//
//  NetworkServices.swift
//  CupcakeCorner
//
//  Created by Наташа Спиридонова on 02.08.2025.
//

import Foundation

enum NetworkError: Error {
    case encodingFailed
    case InvalidURL
    
}

final class NetworkServices {
    static let shared = NetworkServices()
    
    private init() {}
    
    let currencyCode = Locale.current.currency?.identifier ?? "RUB"
    let imageURL = URL(string: "https://hws.dev/img/cupcakes@3x.jpg")!
    let requestURL = URL(string: "https://httpbin.org/post")!
    
    var confirmationMessage = ""
    var showConfirmation = false
    
    func placeOrder(with order: Order) async -> Result<String, Error> {
        guard let encoder = try? JSONEncoder().encode(order) else {
            return .failure(NetworkError.encodingFailed)
        }
        
        var request = URLRequest(url: requestURL)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (_, _) = try await URLSession.shared.upload(for: request, from: encoder)
//            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            let message = "Ваш заказ для \(order.quantity)x \(Order.types[order.type].lowercased()) кексы уже в пути!"
            
            return .success(message)
        } catch {
            return .failure(error)
        }
    }
}
