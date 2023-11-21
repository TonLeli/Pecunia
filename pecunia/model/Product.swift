//
//  Product.swift
//  pecunia
//
//  Created by Wellington on 02/11/23.
//

import Foundation

struct Product: Codable {
    let status: Int
    let resultados: [ProductResult]
}

struct ProductResult: Codable {
    let mercado, nome, preco: String
    let imagem: String
}

