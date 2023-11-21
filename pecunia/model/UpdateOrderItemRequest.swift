//
//  UpdateOrderItemRequest.swift
//  pecunia
//
//  Created by Wellington on 18/11/23.
//

import Foundation

struct UpdateProductSelection: Identifiable {
    var id = UUID()
    var nome: String
    var imagem: String
    var quantidade: Int
    var acao: String
    var idProduto: Int
    
    init(nome: String, imagem: String, quantidade: Int, acao: String, idProduto: Int) {
        self.nome = nome
        self.imagem = imagem
        self.quantidade = quantidade
        self.acao = acao
        self.idProduto = idProduto
    }
}
