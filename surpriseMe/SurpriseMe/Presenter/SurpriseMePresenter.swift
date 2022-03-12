//
//  SurpriseMePresenter.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 12/12/2021.
//

import Foundation

class SurpriseMePresenter: SurpriseMePresenterProtocol {
    var view: SurpriseMeViewProtocol?
    var interactor: SurpriseMeInteractorProtocol?
    var router: SurpriseMeRouterProtocol?
    
    func getFeelings() -> [SurpriseMeFeeling] {
        var feelings: [SurpriseMeFeeling] = []
        for feeling in SurpriseMeFeeling.allCases {
            feelings.append(feeling)
        }
        return feelings
    }
    
    func goToCreatePlayList(feeling: SurpriseMeFeeling) {
        let key = FeelingCategories.getTitle(feeling: feeling)
        EditFeelingArtistsPresenter.getFavs(forKey: key, completion: { [weak self] artists in
            self?.router?.goToCreateList(feeling: feeling, artists: artists)
        })
    }
    
    func goToEditArtists(feeling: SurpriseMeFeeling) {
        router?.goToEditArtists(feeling: feeling)
    }
    
}
