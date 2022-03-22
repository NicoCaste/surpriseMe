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
    var artistsMatch: [ArtistWithImage]? = []
    
    func findArtist(artist: String) {
        view?.lookingForNewFavorite = (artist != "") ? true : false
        if artist == "" {
            view?.tableView.reloadData()
        }
        
        interactor?.findArtist(artist: artist, completion: { [weak self] matchArtist in
            guard let artists = matchArtist?.artists.items else { return }
            self?.setArtistsImage(artists: artists, completion: {
                self?.view?.tableView.reloadData()
            })
            
        })
    }

    
    func goToCreateList(feeling: SurpriseMeFeeling, artists: [ArtistWithImage]) {
        var artistsSeleted: [Artist?] = []
        for artist in artists {
            artistsSeleted.append(artist.artist)
        }
        router?.goToCreateList(feeling: feeling, artists: artistsSeleted)
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
        let artistsList: [Artist?]? = EditFeelingArtistsPresenter.findFavsInUserDefault(forKey: forkey)
        completion(artistsList ?? [])
    }
    
    func getFavs(forKey: String) {
        view?.lookingForNewFavorite = false
        let forkey = forKey
        let artistsList: [Artist?]? = EditFeelingArtistsPresenter.findFavsInUserDefault(forKey: forkey)
        guard let artistsList = artistsList else { return }
        setArtistsImage(artists: artistsList, completion: { [weak self] in
            self?.view?.tableView.reloadData()
        })
    }
    
    private static func findFavsInUserDefault(forKey: String) -> [Artist?]? {
        var artistsList: [Artist?]?
        UserDefaults.standard.synchronize()
        if let data = UserDefaults.standard.value(forKey: forKey) as? Data {
            artistsList = try? PropertyListDecoder().decode([Artist].self, from: data)
        }
        return artistsList
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
        completion(true)
    }
    
    
    private func setArtistsImage(artists: [Artist?], completion: @escaping() -> Void) {
        artistsMatch = []
        var index = 0
        for artist in artists {
            guard let artist = artist else { return }
            let url = artist.images?.first?.url ?? ""
            ApiCaller.shared.getImage(url: url, completion: { [weak self] artistImage in
                let artistWithImage = ArtistWithImage(artist: artist, artistImage: artistImage ?? UIImage())
                self?.artistsMatch?.append(artistWithImage)
                index += 1
                if artists.count == index {
                    completion()
                }
            })
        }
    }
}
