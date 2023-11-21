//
//  PecuniaService.swift
//  pecunia
//
//  Created by Wellington on 15/11/23.
//

import Foundation
import Alamofire

class PecuniaService {
    func makeRequest<T>(serviceRouter: PecuniaServiceRouter, completion: @escaping (Result<T, Error>) -> Void, customBody: [String: Any]? = nil) where T : Decodable {

           AF.request(serviceRouter.url, method: serviceRouter.method, parameters: customBody ?? serviceRouter.params , encoding: JSONEncoding.default, headers: serviceRouter.headers)
               .responseDecodable(of: T.self) { response in
                   switch response.result {
                   case .success(let value):
                       completion(.success(value))
                   case .failure(let error):
                       completion(.failure(error))
                   }
               }.responseJSON { json in
                   
                   print("-------------- DADOS RECEBIDOS DA API --------------")
                   print(json)
                   print("----------------------------------------------------")
               }.cURLDescription { description in
                   print("---------- DADOS ENVIADOS PARA A  API --------------")
                   print(description)
                   print("----------------------------------------------------")
               }
       }
}
