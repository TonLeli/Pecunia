//
//  UpdateOrdersSelectProductsViewModel.swift
//  pecunia
//
//  Created by Wellington on 08/11/23.
//

import Foundation
import SwiftUI

class UpdateOrdersSelectProductsViewModel: ObservableObject {
    private var service = PecuniaService()
    
    @Published var shouldShowLoading = false

    @Published var productsResponse: [ProductOrderResponseItem]? = nil
    @Published var productResponseError: Error? = nil
    
    @Published var saveOrderResponse : SaveOrderResponse? = nil
    @Published var saveOrderResponseError : Error? = nil
    
    @Published var isLoadingButton = false

    func searchProduct(with name: String) {
        shouldShowLoading = true
        service.makeRequest(
            serviceRouter: .searchProductForOrder(productName: name)) { [self] (result: Result<ProductOrderResponse, Error>)  in
                switch result {
                case let .success(product):
                    self.productsResponse = product.resultados
                    shouldShowLoading = false
                    
                case let .failure(error):
                    self.productResponseError = error
                    shouldShowLoading = false
                }
            }
    }
    
    func saveOrder(orderName: String, selectedProducts: [ProductSelection], completion: @escaping (Result<SaveOrderResponse, Error>) -> Void) {
        
        guard let userUid = UserDefaults.standard.string(forKey: "currentUid") else {
            return
        }
        var payloadProducts: [OrderProductItemRequest] = []
        
        selectedProducts.forEach { product in
            payloadProducts.append(
                OrderProductItemRequest(
                    nome: product.product.nome,
                    imagem: product.product.imagem,
                    quantidade: product.selectedQuantity,
                    idProduto: product.product.id
                )
            )
        }
        
        let requestObject = OrderItemsRequest(
            userId: userUid,
            compraNome: orderName,
            itens: payloadProducts
        )

        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(requestObject)
            
            if let jsonDictionary = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [String: Any] {
                
                service.makeRequest(
                    serviceRouter: .saveOrder(
                        userId: userUid, orderName: orderName
                    ),
                    customBody: jsonDictionary
                )
                { (result: Result<SaveOrderResponse, Error>) in
                    completion(result)
                }
            }
        } catch {
            completion(.failure(error))
        }
        
    }
    
}
