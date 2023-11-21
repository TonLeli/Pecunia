//
//  UpdateOrderViewModel.swift
//  pecunia
//
//  Created by Wellington on 09/11/23.
//

import Foundation

class UpdateOrderViewModel: ObservableObject {
    private var service = PecuniaService()
    
    func deleteItem(orderName: String, completion: @escaping (Result<CommonResponse, Error>) -> Void) {
        
        guard let userUid = UserDefaults.standard.string(forKey: "currentUid") else {
            return
        }
        
        service.makeRequest(serviceRouter: .deleteOrder(userId: userUid, orderName: orderName)) { (result: Result<CommonResponse, Error>) in
            completion(result)
        }
        
    }
}
