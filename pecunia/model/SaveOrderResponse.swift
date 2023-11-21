//
//  SaveOrderResponse.swift
//  pecunia
//
//  Created by Wellington on 09/11/23.
//

import Foundation

struct SaveOrderResponse: Decodable {
    let status: Int
    let message: String?
    let error: String?
}
