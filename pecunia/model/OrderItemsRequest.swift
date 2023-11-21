//
//  OrderItemsRequest.swift
//  pecunia
//
//  Created by Wellington on 08/11/23.
//

import Foundation

class OrderItemsRequest: Encodable {
    var userId: String
    var compraNome: String
    var itens: [OrderProductItemRequest]
    
    init(userId: String, compraNome: String, itens: [OrderProductItemRequest]) {
        self.userId = userId
        self.compraNome = compraNome
        self.itens = itens
    }
}

public class OrderProductItemRequest: Codable {
    var nome: String
    var imagem: String
    var quantidade: Int
    var idProduto: Int
    
    enum CodingKeys: String, CodingKey {
        case nome
        case imagem
        case quantidade
        case idProduto
    }
    
    init(nome: String, imagem: String, quantidade: Int, idProduto: Int) {
        self.nome = nome
        self.imagem = imagem
        self.quantidade = quantidade
        self.idProduto = idProduto
    }
}
struct ProductSelection: Encodable {
    var product: ProductOrderResponseItem
    var selectedQuantity: Int
}
