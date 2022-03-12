//
//  SurpriseMeEntity.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 12/12/2021.
//

import UIKit

protocol SurpriseMeViewProtocol {
    var currentFeling: SurpriseMeFeeling? { get }
}

protocol SurpriseMeInteractorProtocol {}

protocol SurpriseMePresenterProtocol {
    func getFeelings() -> [SurpriseMeFeeling]
    func goToCreatePlayList(feeling: SurpriseMeFeeling)
    func goToEditArtists(feeling: SurpriseMeFeeling)
}
protocol SurpriseMeRouterProtocol {
    func goToCreateList(feeling: SurpriseMeFeeling, artists: [Artist?])
    func goToEditArtists(feeling: SurpriseMeFeeling) 
}
