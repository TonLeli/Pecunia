//
//  UpdateOrderPayload.swift
//  pecunia
//
//  Created by Wellington on 19/11/23.
//

import Foundation


struct UpdateOrderPayload: Codable {
    var nome: String
    var imagem: String
    var quantidade: Int? = nil
    var acao: String
    var idProduto: Int
    
    init(nome: String, imagem: String, quantidade: Int? = nil, acao: String, idProduto: Int) {
        self.nome = nome
        self.imagem = imagem
        self.quantidade = quantidade
        self.acao = acao
        self.idProduto = idProduto
    }
}
