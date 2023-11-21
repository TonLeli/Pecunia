//
//  NewAccountViewModel.swift
//  pecunia
//
//  Created by Wellington on 30/10/23.
//

import Foundation

class NewAccountViewModel: ObservableObject {
    private var service = PecuniaService()
    
    func createAccount(email: String, name: String, password: String, completion: @escaping (Result<CommonResponse, Error>) -> Void) {
        service.makeRequest(
            serviceRouter: .newAccount(email: email, password: password, nome: name)) { (result: Result<CommonResponse, Error>) in
                completion(result)
            }
    }

}
