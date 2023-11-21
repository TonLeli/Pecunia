//
//  OrderItems.swift
//  pecunia
//
//  Created by Wellington on 07/11/23.
//

import Foundation

struct OrderItems: Codable {
    let status: Int
    let data: [OrderItemList]
}

struct OrderItemList: Codable {
    let items: [OrderItem]
}

// MARK: - Item
struct OrderItem: Codable {
    let idProduto: Int
    let imagem: String
    let nome: String
    let quantidade: Int
}
