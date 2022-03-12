//
//  AuthModule.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 11/12/2021.
//

import UIKit

final class AuthorizationModule {
    
    static func build(completionHandler: ((Bool) -> Void)?) -> UIViewController {
        let view = AuthorizationViewController()
        let interactor = AuthorizationInteractor()
        let router = AuthorizationRouter()
        let presenter = AuthorizationPresenter()
        view.completionHandler = completionHandler
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view 
        return view 
    }
}
