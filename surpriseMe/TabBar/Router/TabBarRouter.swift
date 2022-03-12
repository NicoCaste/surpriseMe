//
//  TabBarRouter.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 11/12/2021.
//

import UIKit

class TabBarRouter: TabBarRouterProtocol {
    weak var viewController: UITabBarController?
    
    func goToImBoring() -> UINavigationController {
        let imBoringView = ImBoringModule.build()
        imBoringView.navigationItem.largeTitleDisplayMode = .always
        let navigation = UINavigationController(rootViewController: imBoringView)
        return navigation
    }
    
    func goToSurpriseMe() -> UINavigationController {
        let surpriseMeView = SurpriseMeModule.build()
        surpriseMeView.navigationItem.largeTitleDisplayMode = .always
        let navigation = UINavigationController(rootViewController: surpriseMeView)
        return navigation
    }
    
    func goToUserConfig() -> UINavigationController {
        let imBoringView = ProfileModule.build()
        imBoringView.navigationItem.largeTitleDisplayMode = .always
        let navigation = UINavigationController(rootViewController: imBoringView)
        return navigation
    }
}
