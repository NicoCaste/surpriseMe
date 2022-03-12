//
//  SurpriseMe.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 11/12/2021.
//

import UIKit

final class SurpriseMeModule {
    
    static func build() -> UIViewController {
        let view = SurpriseMeViewController()
        let interactor = SurpriseMeInteractor()
        let router = SupriseMeRouter()
        let presenter = SurpriseMePresenter()
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
}
