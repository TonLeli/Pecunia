//
//  UpdateOrderBottomSheetViewModel.swift
//  pecunia
//
//  Created by gabriel on 08/11/23.
//

import Foundation


class UpdateOrderBottomSheetViewModel: ObservableObject {
    
    let service = PecuniaService()
    
    func validateOrderName(orderName: String, completion: @escaping (Result<ValidateOrder, Error>) -> Void) {
        
        let userUid = UserDefaults.standard.string(forKey: "currentUid") ?? String()
        
        service.makeRequest(
            serviceRouter: .validateOrderName(userID: userUid, orderName: orderName)) { (result: Result<ValidateOrder, Error>) in
                completion(result)
            }
    }
}
