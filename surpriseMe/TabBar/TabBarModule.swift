//
//  TabBarModule.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 11/12/2021.
//

import UIKit

final class TabBarModule {
    
    static func build() -> UITabBarController {
        let view = TabBarViewController()
        let interactor = TabBarInteractor()
        let router = TabBarRouter()
        let presenter = TabBarPresenter()
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
}
