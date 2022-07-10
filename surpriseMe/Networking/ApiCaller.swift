//
//  ApiCaller.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 12/12/2021.
//

import Foundation
import Alamofire 

class ApiCaller {
    static var shared = ApiCaller()
    private init() {}
    let apiBaseUrl = "https://api.spotify.com/v1/"
    
    func makeURL(url: String) -> String {
        let url = apiBaseUrl + url
        return url
    }
    
    func getImage(url: String, completion: @escaping(UIImage?) -> Void) {
        var imageUrl = url
        
        if url.lowercased().contains("https") == false {
            imageUrl = "https://\(url)"
        }
        
        if url.lowercased().contains("http") {
            imageUrl = imageUrl.replacingOccurrences(of: "http://", with: "", options: .literal)
        }
        
        AF.download(imageUrl).responseData(completionHandler: { response in
            if let data = response.value {
                let image = UIImage(data: data)
                completion(image)
            } else {
                completion(UIImage(systemName: "camera.circel") ?? UIImage())
            }
        })
    }
}
