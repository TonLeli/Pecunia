//
//  ProductOrderResponse.swift
//  pecunia
//
//  Created by Wellington on 08/11/23.
//

struct ProductOrderResponse: Codable {
    let status: Int
    let resultados: [ProductOrderResponseItem]
}


struct ProductOrderResponseItem: Codable {
    let nome: String
    let id: Int
    let imagem: String
}

