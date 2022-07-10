//
//  webService.swift
//  surpriseMe
//
//  Created by nicolas castello on 09/07/2022.
//

import Foundation
enum HttpMethod: String {
    case get
    case post
}

protocol WebService {
    func post(_ urlString: String, parameters:  Parameters, completion: @escaping(Result<Data, Error>) -> Void)
    func get(_ urlString: String, parameters:  Parameters, completion: @escaping(Result<Data, Error>) -> Void)
    func getImage(_ urlString: String, completion: @escaping(Result<Data, Error>) -> Void)
}
