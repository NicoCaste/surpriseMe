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
    var manager: AlamofireWebService = AlamofireWebService()
    var repository: SurpriseMeApiRepository
    
    init() {
        self.repository = SurpriseMeApiRepository(webService: manager)
    }
    
    func findArtist(artist: String, completion: @escaping((EditFeeling?) -> Void)) {
        let editArtist = artist.replacingOccurrences(of: " ", with: "%20")
        let url = ApiCaller.shared.makeURL(url: "search?q=\(editArtist)&type=artist&limit=10")
        repository.findArtist(baseUrl: url, completion: { artists in
            switch artists {
            case .success(let artistsMatch):
                completion(artistsMatch)
            case .failure:
                //TODO: - Handler better error case 
                completion(nil)
            }
        })
    }
}
