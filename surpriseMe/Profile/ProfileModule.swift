//
//  UserConfigModule.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 11/12/2021.
//

import UIKit

final class ProfileModule {
    
    static func build() -> UIViewController {
        let view = ProfileViewController()
        let interactor = ProfileInteractor()
        let router = ProfileRouter()
        let presenter = ProfilePresenter()
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
}
