//
//  ProfileInteractor.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 12/12/2021.
//

import UIKit
import Alamofire
class ProfileInteractor: ProfileInteractorProtocol {
    var presenter: ProfilePresenterProtocol?
    
    func getuserData(completion: @escaping((DataResponse< Profile, AFError>) -> Void)) {
        AuthorizationInteractor.getToken(completion: { token in
            guard let token = token else { return }
            let headers: HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
            let url = ApiCaller.shared.makeURL(url: "me")
            AF.request(url, headers: headers).responseDecodable(of: Profile.self) { ProfileData in
              completion(ProfileData)
            }
        })
    }
    
    func cacheClient(result: Profile) {
        UserDefaults.standard.setValue(result.id, forKey: "client_id")
        UserDefaults.standard.setValue(result.displayName, forKey: "client_name")
        UserDefaults.standard.setValue(result.email, forKey: "client_email")
        UserDefaults.standard.setValue(result.product, forKey: "client_product")
    }
    
    static func getClientData(userData: UserConfigTrakingSection) -> String? {
        var clientData = ""
        switch userData {
        case .name:
            clientData = UserDefaults.standard.string(forKey: "client_name") ?? ""
        case .email:
            clientData = UserDefaults.standard.string(forKey: "client_email") ?? ""
        case .id:
            clientData = UserDefaults.standard.string(forKey: "client_id") ?? ""
        case .plan:
            clientData = UserDefaults.standard.string(forKey: "client_product") ?? ""
        default:
            return nil
        }
        return clientData
    }
}
