//
//  OrderValue.swift
//  pecunia
//
//  Created by Wellington on 16/11/23.
//

import Foundation

struct OrderValue: Decodable {
    
    let status: Int
    let data: [OrderListItem]
    
    enum CodingKeys: String, CodingKey {
        case status
        case data
    }

}

struct OrderListItem: Codable {
    let markets: [String: String]
    let listMarkets: [OrderValueMarket]

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        markets = try container.decode([String: String].self)
        
        // Converte o dicionário em uma lista de OrderValueMarket
        listMarkets = markets.map { OrderValueMarket(marketName: $0.key, marketValue: Double($0.value) ?? 0.0) }
    }
}

struct OrderValueMarket: Codable {
    let marketName: String
    let marketValue: Double
}
