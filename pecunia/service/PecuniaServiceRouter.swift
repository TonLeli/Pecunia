//
//  PecuniaServiceRouter.swift
//  pecunia
//
//  Created by Wellington on 15/11/23.
//

import Foundation
import Alamofire

enum PecuniaServiceRouter {
    case login(email: String, password: String)
    case forgotPassword(email: String)
    case sendCode(email: String, password: String, code: String)
    case newAccount(email: String, password: String, nome: String)
    case searchProduct(productName: String)
    case validateOrderName(userID: String, orderName: String)
    case searchProductForOrder(productName: String)
    case saveOrder(userId: String, orderName: String)
    case getOrders(userID: String)
    case getOrderItems(userID: String, order: String)
    case deleteOrder(userId: String, orderName: String)
    case getOrderValue(userUid: String, orderName: String)
    case getSavedOrderProducts(userUID: String, orderName: String)
    case updateOrder(userUID: String, orderName: String)
    
    var url: String {
        switch self {
        case .login:
            return "https://pecunia-api.onrender.com/signinUser"
        case .forgotPassword:
            return  "https://pecunia-api.onrender.com/forgotMyPass"
        case .sendCode:
            return "https://pecunia-api.onrender.com/resetPassword"
        case .newAccount:
            return "https://pecunia-api.onrender.com/signupUser"
        case let .searchProduct(productName):
            return "https://pecunia-api.onrender.com/searchProduct/\(productName)"
        case let .validateOrderName(userID, orderName):
            return "https://pecunia-api.onrender.com/validateOrderName/\(userID)/\(orderName)"
            
        case let .searchProductForOrder(productName):
            return "https://pecunia-api.onrender.com/searchProductForOrder/\(productName)"
        case .saveOrder:
            return  "https://pecunia-api.onrender.com/createOrder"
        case let .getOrders(userID):
            return "https://pecunia-api.onrender.com/getOrders/\(userID)"
        case let .getOrderItems(userID, order):
            return "https://pecunia-api.onrender.com/getOrderItems/\(userID)/\(order)"
        case let .deleteOrder(userId, orderName):
            return "https://pecunia-api.onrender.com/deleteOrder/\(userId)/\(orderName)"
        case let .getOrderValue(userUid, orderName):
            return "https://pecunia-api.onrender.com/orderValue/\(userUid)/\(orderName)"
        case let .getSavedOrderProducts(userUID, orderName):
            return "https://pecunia-api.onrender.com/getOrderItems/\(userUID)/\(orderName)"
        case let .updateOrder(userUID, orderName):
            return "https://pecunia-api.onrender.com/updateOrder/\(userUID)/\(orderName)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login, .forgotPassword, .sendCode, .newAccount, .saveOrder:
            return .post
        case .searchProduct, .validateOrderName, .searchProductForOrder, .getOrders, .getOrderItems, .getOrderValue, .getSavedOrderProducts:
            return .get
        case .deleteOrder:
            return .delete
        case .updateOrder:
            return .put
        }
    }
    
    var params: [String : Any]? {
        switch self {
        case let .login(email, password):
            return [
                "Email": email,
                "Senha": password
            ]
        case let .forgotPassword(email):
            return [
                "email": email
            ]
        case let .sendCode(email, password, code):
            return [
                "email": email,
                "code": code,
                "new_password": password
            ]
            
        case let .newAccount(email, password, nome):
            return [
                "Nome": nome,
                "Email": email,
                "Senha": password
            ]
            
        default:
            return nil
        }
    }
    
    var headers: HTTPHeaders {
        return [
            "Authorization"  : "UGVjdW5pYTpxdm1jc3JiZHVhbXN4eWVl"
        ]
    }
}
