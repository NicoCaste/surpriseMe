//
//  AuthorizationInteractor.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 11/12/2021.
//

import Foundation

struct AuthResponse: Codable {
    var accessToken: String?
    var expiresIn: Int?
    var refreshToken: String?
    var scope: String?
    var tokenType: String?
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case scope
        case tokenType = "token_type"
    }
}

class AuthorizationInteractor: AuthorizationInteractorProtocol {
    var presenter: AuthorizationPresenterProtocol?
    
    struct Constant {
        static let clientId = ApiKeyManager.getPublicClientId() ?? ""
        static let secretId = ApiKeyManager.getSecretApiKey() ?? ""
        static let tokenApiURL: String = "https://accounts.spotify.com/api/token"
        static let redirectURI = "https://www.spotify.com/ar/"
        static let scopes = "user-read-private%20playlist-modify-public%20playlist-read-private%20playlist-modify-private%20playlist-read-collaborative%20user-follow-read%20user-library-modify%20user-library-read%20user-read-email"
    }
    
    func singInUrl () -> URL? {
        let base = "https://accounts.spotify.com/authorize/"
        let stringURL = "\(base)?response_type=code&client_id=\(Constant.clientId)&scope=\(Constant.scopes)&redirect_uri=\(Constant.redirectURI)&show_dialog=TRUE"
        return URL(string: stringURL)
    }
    
    static var isSignedIn: Bool {
        return accesToken != nil
    }
    
    static var accesToken: String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }
    
    static private var refreshToken: String? {
        return UserDefaults.standard.string(forKey: "refresh_token")
    }
    
    static private var tokenExpirationDate: Date? {
        return UserDefaults.standard.object(forKey: "expires_Date") as? Date
    }
    
    static var shouldRefreshToken: Bool {
        guard accesToken != nil else { return false }
        guard let tokenExpirationDate = tokenExpirationDate else { return true }
        let currentDate = Date()
        let fiveMinutes: TimeInterval = 300
        return currentDate.addingTimeInterval(fiveMinutes) >= tokenExpirationDate
    }
    
    // MARK: - ExchangeCodeForToken
    func exchangeCodeForToken(code: String, completion: @escaping((Bool) -> Void)) {
        guard let url = URL(string: Constant.tokenApiURL) else { return }
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: "https://www.spotify.com/ar/"),
            URLQueryItem(name: "grant_type", value: "authorization_code")
        ]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = components.query?.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-type")
        
        let basicToken = Constant.clientId + ":" + Constant.secretId
        let data = basicToken.data(using: .utf8)
        guard let encodingValue = data?.base64EncodedString() else {
            completion(false)
            return }
        request.setValue("Basic \(encodingValue)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error ==  nil else {
                completion(false)
                return
            }
            do {
                let response = try JSONDecoder().decode(AuthResponse.self, from: data)
                AuthorizationInteractor.cacheToken(result: response)
                completion(true)
            } catch {
                print(error.localizedDescription)
                completion(false)
            }
        }
        task.resume()
    }
    
    // MARK: - RefreshAccessToken
    static func refreshAccessToken(completion: @escaping((Bool) -> Void)) {
        guard shouldRefreshToken else { return }
        guard let refreshToken = refreshToken else { return }
        
        //Refresh token
        guard let url = URL(string: Constant.tokenApiURL) else { return }
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            URLQueryItem(name: "refresh_token", value: refreshToken),
            URLQueryItem(name: "grant_type", value: "authorization_code")
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = components.query?.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-type")
        
        let basicToken = Constant.clientId + ":" + Constant.secretId
        let data = basicToken.data(using: .utf8)
        guard let encodingValue = data?.base64EncodedString() else {
            completion(false)
            return }
        request.setValue("Basic \(encodingValue)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error ==  nil else {
                completion(false)
                return
            }
            do {
                let response = try JSONDecoder().decode(AuthResponse.self, from: data)
                self.cacheToken(result: response)
                completion(true)
            } catch {
                print(error.localizedDescription)
                completion(false)
            }
        }
        task.resume()

    }
    
    // MARK: - CacheToken
    static private func cacheToken(result: AuthResponse) {
        UserDefaults.standard.setValue(result.accessToken, forKey: "access_token")
        if let refreshToken = result.refreshToken {
            UserDefaults.standard.setValue(refreshToken, forKey: "refresh_token")
        }
        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.expiresIn ?? 0)), forKey: "expires_Date")
    }
    
    // MARK: - GetToken
    static func getToken(completion: @escaping((String?)-> Void)) {
        var token: String?
        if AuthorizationInteractor.shouldRefreshToken {
            AuthorizationInteractor.refreshAccessToken(completion: { successToken in
              token = AuthorizationInteractor.accesToken ?? ""
              completion(token)
            })
        } else {
            token = AuthorizationInteractor.accesToken
            completion(token)
        }
    }
}
