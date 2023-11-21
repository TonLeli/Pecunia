//
//  RecoveryPasswordViewModel.swift
//  pecunia
//
//  Created by Wellington on 29/10/23.
//

import Foundation
import Combine

class RecoveryPasswordViewModel: ObservableObject {
    private var service = PecuniaService()
    public var currentEmail = String()
    public var currentPassword = String()
    let passwordRegex = "^(?=.*\\d)(?=.*[!@#\\$%^&*()_\\-+=\\[\\]\\{\\}\\|;:'\",.<>\\?/]).{8,}$"
    
    func sendCodeEmail(email: String, completion: @escaping (Result<CommonResponse, Error>) -> Void) {
        service.makeRequest(
            serviceRouter: .forgotPassword(email: email)) { (result: Result<CommonResponse, Error>) in
                completion(result)
            }
    }
    
    func resetPassword(code: String, completion: @escaping (Result<CommonResponse, Error>) -> Void) {
        service.makeRequest(
            serviceRouter: .sendCode(email: currentEmail, password: currentPassword, code: code)) { (result: Result<CommonResponse, Error>) in
                completion(result)
            }
    }
    
    func isValidPassword(password: String) -> Bool {
        
        let regex = try! NSRegularExpression(pattern: passwordRegex)
        let range = NSRange(location: 0, length: password.utf16.count)
        
        if regex.firstMatch(in: password, options: [], range: range) == nil {
            return false
        } else {
            return true
        }
    }
}
