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
    var reloadArtistsMatch: Bool = true
    
    init() {
        self.repository = SurpriseMeApiRepository(webService: manager)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadArtists), name:  NSNotification.Name.reloadArtistsMatch, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.reloadArtistsMatch, object: nil)
    }
    
    func findArtist(artist: String, completion: @escaping((EditFeeling?) -> Void)) {
        let editArtist = artist.replacingOccurrences(of: " ", with: "%20")
        let url = ApiCaller.shared.makeURL(url: "search?q=\(editArtist)&type=artist&limit=10")
        repository.findArtist(baseUrl: url, completion: {[weak self] artists in
            switch artists {
            case .success(let artistsMatch):
                if artistsMatch.artists.items.isEmpty {
                    ShowErrorManager.showErrorView(title: "ups".localized(), description: "anyArtist".localized())
                }
                if self?.reloadArtistsMatch == true {
                    completion(artistsMatch)
                } else {
                    self?.reloadArtistsMatch = true
                }
            case .failure:
                if !artist.isEmpty {
                    ShowErrorManager.showErrorView(title: "ups".localized(), description: "anyArtist".localized())
                }
                completion(nil)
            }
        })
    }
    
    @objc func reloadArtists() {
        self.reloadArtistsMatch = false
    }
}
