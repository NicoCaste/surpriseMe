//
//  AlamofireWebService.swift
//  surpriseMe
//
//  Created by nicolas castello on 09/07/2022.
//

import Foundation
import Alamofire

final class AlamofireWebService: WebService {
    func get(_ urlString: String, parameters: Parameters, completion: @escaping (Result<Data, Error>) -> Void) {
        AuthorizationInteractor.getToken(completion: { token in
            guard let token = token else { return }
            let headers: HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]

            AF.request( urlString, parameters: parameters, headers: headers).responseData { response in
                    if let data = response.value {
                        completion(.success(data))
                    } else if let error = response.error {
                        completion(.failure(error))
                    } else {
                        print("error desconocido")
                    }
            }
        })
    }
    
    
    func post(_ urlString: String, parameters: Parameters, completion: @escaping (Result<Data, Error>) -> Void) {

        AuthorizationInteractor.getToken(completion: { token in
            let encoder = JSONEncoder() // create encoder to encode your request parameters to Data
            guard let token = token,
                  let data = try? encoder.encode(parameters),
                  let url = URL(string: urlString) else { return }
            var urlRequest = URLRequest(url: url)
            let headers: HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]

            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = data
            urlRequest.headers = headers
            urlRequest.httpMethod = "POST"
            
            AF.request(urlRequest).responseData { response in
                    if let data = response.value {
                        completion(.success(data))
                    } else if let error = response.error {
                        completion(.failure(error))
                    } else {
                        print("error desconocido")
                    }
            }
        })
    }
    
    func getImage(_ urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
            print("QUE")
    }
}
