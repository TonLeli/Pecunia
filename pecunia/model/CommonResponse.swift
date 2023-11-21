//
//  CommonResponse.swift
//  pecunia
//
//  Created by Wellington on 16/11/23.
//

import Foundation

struct CommonResponse: Decodable {
    var status: Int
    var message: String?
    var error: String?
}
