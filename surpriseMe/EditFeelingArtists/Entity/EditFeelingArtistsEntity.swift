//
//  EditFeelingArtistsEntity.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 19/02/2022.
//

import UIKit

protocol EditFeelingArtistsViewProtocol {
    var tableView: UITableView { get }
    var lookingForNewFavorite: Bool { get set }
}

protocol EditFeelingArtistsInteractorProtocol {
    func findArtist(artist: String, completion: @escaping((EditFeeling?) -> Void))
}

protocol EditFeelingArtistsPresenterProtocol {
    var feeling: SurpriseMeFeeling? { get }
    var artistsMatch: [ArtistWithImage]? { get }
    func goToCreateList(feeling: SurpriseMeFeeling, artists: [ArtistWithImage])
    func findArtist(artist: String)
    func setFavList(forKey: String, fav: Artist, completion: @escaping (Bool) -> Void)
    func removeFav(forKey: String, fav: Artist, completion: @escaping (Bool) -> Void)
    func getFavs(forKey: String)
}
protocol EditFeelingArtistsRouterProtocol {
    func goToCreateList(feeling: SurpriseMeFeeling, artists: [Artist?])
}
