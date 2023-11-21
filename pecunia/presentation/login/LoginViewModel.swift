//
//  LoginViewModel.swift
//  pecunia
//
//  Created by Wellington on 30/10/23.
//

import Foundation


class LoginViewModel: ObservableObject {
    private var service = PecuniaService()
    
    func login(email: String, password: String, completion: @escaping (Result<Login, Error>) -> Void) {
        service.makeRequest(
            serviceRouter: .login(email: email, password: password)) { (result: Result<Login, Error>) in
                completion(result)
            }
    }
}
