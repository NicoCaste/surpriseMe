//
//  EditFeelingArtistsPresenter.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 19/02/2022.
//

import Foundation
import UIKit

class EditFeelingArtistsPresenter: EditFeelingArtistsPresenterProtocol {
    var view: EditFeelingArtistsViewProtocol?
    var interactor: EditFeelingArtistsInteractorProtocol?
    var router: EditFeelingArtistsRouterProtocol?
    var feeling: SurpriseMeFeeling?
    var artistsMatch: [Artist?]?
    
    func findArtist(artist: String, completion: @escaping((EditFeeling?) -> Void)) {
        interactor?.findArtist(artist: artist, completion: { [weak self] matchArtist in
            self?.artistsMatch = matchArtist?.artists.items
            completion(matchArtist)
        })
    }
    
    func goToCreateList(feeling: SurpriseMeFeeling, artists: [Artist?]) {
        router?.goToCreateList(feeling: feeling, artists: artists)
    }
    
    func setFavList(forKey: String, fav: Artist, completion: @escaping (Bool) -> Void) {
        let forkey = forKey
        var artistsList: [Artist?] = []
        if let data = UserDefaults.standard.value(forKey: forkey) as? Data {
            guard let artists = try? PropertyListDecoder().decode([Artist].self, from: data) else {
                completion(false)
                return
            }
            UserDefaults.standard.removeObject(forKey: forkey)
            UserDefaults.standard.synchronize()
            artistsList = artists
        }
        artistsList.append(fav)
        UserDefaults.standard.set(try? PropertyListEncoder().encode(artistsList), forKey: forkey)
        UserDefaults.standard.synchronize()
        completion(true)
    }

    // Returns a list with the Artists saved in userDefaults
    static func getFavs(forKey: String, completion: @escaping ([Artist?]) -> Void) {
        let forkey = forKey
        var artistsList: [Artist]?
        if let data = UserDefaults.standard.value(forKey: forkey) as? Data {
            artistsList = try? PropertyListDecoder().decode([Artist].self, from: data)
        }
        completion(artistsList ?? [])
    }

    func removeFav(forKey: String, fav: Artist, completion: @escaping (Bool) -> Void) {
        let forkey = forKey
        var artistsList: [Artist?] = []
        if let data = UserDefaults.standard.value(forKey: forkey) as? Data {
            guard let artists = try? PropertyListDecoder().decode([Artist].self, from: data) else {
                completion(false)
                return
            }
            UserDefaults.standard.removeObject(forKey: forkey)
            UserDefaults.standard.synchronize()
            artistsList = artists
        }
        let findArtist = artistsList.firstIndex(where: { $0?.id == fav.id })
        if let findArtist = findArtist {
            artistsList.remove(at: findArtist)
        }
        UserDefaults.standard.set(try? PropertyListEncoder().encode(artistsList), forKey: forkey)
        UserDefaults.standard.synchronize()
        artistsMatch = artistsList
        completion(true)
    }
}
