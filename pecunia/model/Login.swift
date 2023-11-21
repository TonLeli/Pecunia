//
//  Login.swift
//  pecunia
//
//  Created by Wellington on 15/11/23.
//

import Foundation

struct Login: Decodable {
    var status: Int
    var uid: String?
    var nome: String?
    var message: String?
    var error: String?
}
