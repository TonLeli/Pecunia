//
//  UpdateProductOrderViewModel.swift
//  pecunia
//
//  Created by Wellington on 18/11/23.
//

import Foundation

class UpdateProductOrderViewModel: ObservableObject {
    let service = PecuniaService()
    
    @Published var productsList: [EditOrderItemListItem]? = nil
    @Published var shouldShowLoading = false
    @Published var productResponseError: Error? = nil
    @Published var productsResponse: [ProductOrderResponseItem]? = nil
    
    func getSavedProducts(orderName: String) {
        
        guard let userUid = UserDefaults.standard.string(forKey: "currentUid") else {
            return
        }
        service.makeRequest(serviceRouter: .getSavedOrderProducts(userUID: userUid, orderName: orderName)) { [self] (result: Result<EditOrderItemList, Error>) in
            switch result {
            case let .success(product):
                if let items = product.data.first?.items {
                    productsList = items
                    shouldShowLoading = false
                }
                
            case let .failure(error):
                productResponseError = error
                shouldShowLoading = false
            }
        }
        
        shouldShowLoading = true
        
    }
    
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
    
    func updateOrder(products: [UpdateProductSelection], orderName: String, completion: @escaping (Result<UpdateOrderResponse, Error>) -> Void) {
        
        guard let userUid = UserDefaults.standard.string(forKey: "currentUid") else {
            return
        }
        
        var payloadList: [UpdateOrderPayload] = []
        
        products.forEach { productSelected in
            payloadList.append(
                UpdateOrderPayload(
                    nome: productSelected.nome,
                    imagem: productSelected.imagem,
                    quantidade: productSelected.acao == "remover" ? nil : productSelected.quantidade, acao: productSelected.acao,
                    idProduto: productSelected.idProduto
                )
            )
        }
        
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(payloadList)
            
            if let jsonDictionary = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [[String: Any]] {
            
                guard let url = URL(string: "https://pecunia-api.onrender.com/updateOrder/\(userUid)/\(orderName)") else {
                    return
                }
                
                let jsonData = try JSONSerialization.data(withJSONObject: jsonDictionary, options: [])
                
                var request = URLRequest(url: url)
                request.httpMethod = "PUT"
                request.addValue("UGVjdW5pYTpxdm1jc3JiZHVhbXN4eWVl", forHTTPHeaderField: "Authorization")
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = jsonData
                
                
                URLSession.shared.dataTask(with: request) { (data, response, error) in
                    guard error == nil else {
                        completion(.failure(error ?? NSError(domain: "Erro desconhecido", code: 422)))
                        return
                    }
                    guard let data = data else {
                        completion(.failure(error ?? NSError(domain: "Erro desconhecido", code: 422)))
                        return
                    }
                    
                    if let object = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                        
                        guard let status = object["status"] as? Int else {
                            return
                        }
                        
                        guard let message = object["message"] as? String else {
                            return
                        }
                        
                        let response = UpdateOrderResponse(
                            status: status,
                            message: message,
                            warning: []
                        )
                        
                        completion(.success(response))
                    } else {
                        completion(.failure(error ?? NSError(domain: "Erro de parse", code: 422)))
                    }
                }.resume()

            }
        } catch {
            completion(.failure(error))
        }
        
    }
    
}
