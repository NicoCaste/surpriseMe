//
//  EditFeelingArtistsInteractor.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 19/02/2022.
//

import Foundation
import Alamofire

class EditFeelingArtistsInteractor: EditFeelingArtistsInteractorProtocol {
    var presenter: EditFeelingArtistsPresenterProtocol?
    
    func findArtist(artist: String, completion: @escaping((EditFeeling?) -> Void)) {
        let editArtist = artist.replacingOccurrences(of: " ", with: "%20")
        AuthorizationInteractor.getToken(completion: {[weak self] token in
            guard let token = token else { return }

            let headers: HTTPHeaders = [.authorization(bearerToken: token), .contentType("application/json")]
            let url = ApiCaller.shared.makeURL(url:   "search?q=\(editArtist)&type=artist&limit=10")
            AF.request( url, headers: headers).responseDecodable(of: EditFeeling.self) { artistMatch in
                switch artistMatch.result {
                case .success:
                    print(artistMatch)
                    completion(artistMatch.value)
                case .failure:
                    completion(nil)
                }
            }
        })
    }
}
