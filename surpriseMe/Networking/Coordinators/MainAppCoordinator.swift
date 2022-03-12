//
//  MainAppCoordinator.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 11/12/2021.
//

import UIKit

class MainAppCoordinator: MainProtocolCoordinator {
    var childCoordinators = [MainProtocolCoordinator]()
    var navigationController: UINavigationController
    var menuOpened = false

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = WelcomeViewController()
        viewController.coordinator = self
        self.navigationController.pushViewController(viewController, animated: true)
    }

    func goToHome() {
        self.navigationController.popToRootViewController(animated: true)
    }

    func goToBack() {
        self.navigationController.popViewController(animated: false)
    }
    
    func goToAuthorization(completionHandler: ((Bool) -> Void)?) {
        let viewController = AuthorizationModule.build(completionHandler: completionHandler)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
}
