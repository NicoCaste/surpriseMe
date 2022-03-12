//
//  AuthManager.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 11/12/2021.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    
    private init() {}
    
    struct Constant {
        static let clientId: String = "2653e7e59ec34be090f5d3b3a54f2f77" //makeAClientIdInSpotify
        static let secretId: String = "416efcdbb2a1405da43e0784432c6b62" //makeASecretIdInSpotify
    }
    
    var singInUrl: URL? {
        let scopes = "user-read-private"
        let redirectURI = "https://www.spotify.com/ar/"
        let base = "https://accounts.spotify.com/authorize/"
        let stringURL = "\(base)?response_type=code&client_id=\(Constant.clientId)&scope=\(scopes)&redirect_uri=\(redirectURI)"
        return URL(string: stringURL)
    }
    
    var isSignedIn: Bool {
        return false
    }
    
    private var accesToken: String? {
        return nil
    }
    
    private var refreshToken: String? {
        return nil
    }
    
    private var tokenExpirationDate: Date? {
        return nil
    }
    
    private var shouldRefreshToken: Bool {
        return false
    }
}
