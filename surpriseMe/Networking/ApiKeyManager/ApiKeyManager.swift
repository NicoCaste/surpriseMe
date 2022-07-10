//
//  ApiKeyManager.swift
//  surpriseMe
//
//  Created by nicolas castello on 09/07/2022.
//

import Foundation


final class ApiKeyManager {
    
    static func getPublicClientId() -> String? {
         return  Bundle.main.object(forInfoDictionaryKey: "CLIENT_ID") as? String
    }
    
    static func getSecretApiKey() -> String? {
        return  Bundle.main.object(forInfoDictionaryKey: "SECRET_KEY") as? String
    }
}
