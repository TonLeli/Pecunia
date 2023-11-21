//
//  EditOrderItemList.swift
//  pecunia
//
//  Created by Wellington on 18/11/23.
//

import Foundation

struct EditOrderItemList: Decodable {
    let status: Int
    let data: [EditOrderItemListData]
}

struct EditOrderItemListData: Decodable {
    let items: [EditOrderItemListItem]
}

struct EditOrderItemListItem: Decodable {
    let idProduto: Int
    let imagem: String
    let nome: String
    let quantidade: Int
}
