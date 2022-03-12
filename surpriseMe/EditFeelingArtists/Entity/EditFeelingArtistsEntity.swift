//
//  EditFeelingArtistsEntity.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 19/02/2022.
//

import UIKit

protocol EditFeelingArtistsViewProtocol {
}

protocol EditFeelingArtistsInteractorProtocol {
    func findArtist(artist: String, completion: @escaping((EditFeeling?) -> Void))
}

protocol EditFeelingArtistsPresenterProtocol {
    var feeling: SurpriseMeFeeling? { get }
    var artistsMatch: [Artist?]? { get }
    func goToCreateList(feeling: SurpriseMeFeeling, artists: [Artist?])
    func findArtist(artist: String, completion: @escaping((EditFeeling?) -> Void))
    func setFavList(forKey: String, fav: Artist, completion: @escaping (Bool) -> Void)
    func removeFav(forKey: String, fav: Artist, completion: @escaping (Bool) -> Void)
    static func getFavs(forKey: String, completion: @escaping ([Artist?]) -> Void)
}
protocol EditFeelingArtistsRouterProtocol {
    func goToCreateList(feeling: SurpriseMeFeeling, artists: [Artist?])
}
