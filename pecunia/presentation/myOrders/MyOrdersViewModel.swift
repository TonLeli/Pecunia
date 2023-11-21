//
//  MyOrdersViewModel.swift
//  pecunia
//
//  Created by Wellington on 07/11/23.
//

import Foundation

class MyOrdersViewModel: ObservableObject {
    private var service = PecuniaService()

    @Published var shouldShowLoading = false
    @Published var ordersResponse: OrderData? = nil
    @Published var orderResponseError: String? = nil
    
    @Published var ordersValue: OrderValue? = nil

    func getOrders(completion: @escaping (Result<Order, Error>) -> Void) {
        
        guard let userUid = UserDefaults.standard.string(forKey: "currentUid") else {
            return
        }
        
        shouldShowLoading = true

        service.makeRequest(serviceRouter: .getOrders(userID: userUid)) { (result: Result<Order, Error>) in
                completion(result)
        }
    }
    
    
    func getOrderValue(orderName: String, completion: @escaping (Result<OrderValue, Error>) -> Void) {
        
        guard let userUid = UserDefaults.standard.string(forKey: "currentUid") else {
            return
        }
        
        service.makeRequest(
            serviceRouter: .getOrderValue(userUid: userUid, orderName: orderName)) { (result: Result<OrderValue, Error>) in
                completion(result)
            }
    }
    
//    func getValuesList(orderValue: OrderValue) {
//        let marketsDict = orderValue.data.first?.markets
//        
//    }
    
  
}

