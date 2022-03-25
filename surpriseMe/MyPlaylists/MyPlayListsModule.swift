//
//  MyPlayListsModule.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 11/12/2021.
//

import UIKit

final class MyPlayListsModule {
    
    static func build() -> UIViewController {
        let view = MyPlayListsViewController()
//        let interactor = AuthorizationInteractor()
//        let router = AuthorizationRouter()
//        let presenter = AuthorizationPresenter()
//        view.completionHandler = completionHandler
//        presenter.view = view
//        presenter.interactor = interactor
//        presenter.router = router
//        view.presenter = presenter
//        interactor.presenter = presenter
//        router.viewController = view
        return view
    }
}
