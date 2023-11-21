//
//  Order.swift
//  pecunia
//
//  Created by Wellington on 07/11/23.
//

import Foundation

class Order: Codable {
    let status: Int
    var data: [OrderData]? = []
    var isFull: Bool? = false
    var message: String? = nil
    var orderItems: [OrderItem]? = nil
}

class OrderData: Codable {
    let nomeCompra: String
}
