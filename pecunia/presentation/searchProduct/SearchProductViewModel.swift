//
//  SearchProductViewModel.swift
//  pecunia
//
//  Created by Wellington on 02/11/23.
//

import Foundation
import SwiftUI

class SearchProductViewModel: ObservableObject {
    private var service = PecuniaService()
    
    @Published var shouldShowLoading = false

    @Published var productsResponse: [ProductResult]? = nil
    @Published var productResponseError: Error? = nil

    func searchProduct(with name: String) {
        shouldShowLoading = true
        service.makeRequest(
            serviceRouter: .searchProduct(productName: name)) { [self] (result: Result<Product, Error>)  in
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
    
}
