//
//  CreatePlayListModule.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 13/12/2021.
//

import UIKit

final class CreatePlayListModule {
    
    static func build(feeling: SurpriseMeFeeling, artists: [Artist?]) -> UIViewController {
        let view = CreatePlayListViewController()
        let interactor = CreatePlayListInteractor()
        let router = CreatePlayListRouter()
        let presenter = CreatePlayListPresenter()
        presenter.feeling = feeling
        presenter.artists = artists
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
}
