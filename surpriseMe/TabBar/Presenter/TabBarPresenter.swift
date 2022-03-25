//
//  TabBarPresenter.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 11/12/2021.
//

import UIKit

class TabBarPresenter: TabBarPresenterProtocol {
    var view: TabBarViewControllerProtocol?
    var interactor: TabBarInteractorProtocol?
    var router: TabBarRouterProtocol?
    
    func showNavigators() -> [UINavigationController] {
        var navigators: [UINavigationController] = []
        guard let router = router else { return [] }
        let navigatorImBoring = router.goToImBoring()
        let navigatorSurpriseMe = router.goToSurpriseMe()
        let navigatorUserConfig = router.goToUserConfig()
        
        navigatorImBoring.tabBarItem = UITabBarItem(title: "My PlayLists", image: UIImage(systemName: "music.note.list"), tag: 1)
        navigatorImBoring.navigationBar.prefersLargeTitles = true
        
        navigatorSurpriseMe.tabBarItem = UITabBarItem(title: "Surprise Me!", image: UIImage(systemName: "earbuds"), tag: 1)
        navigatorSurpriseMe.navigationBar.prefersLargeTitles = true
        
        navigatorUserConfig.tabBarItem = UITabBarItem(title: "User Config", image: UIImage(systemName: "figure.wave"), tag: 1)
        navigatorUserConfig.navigationBar.prefersLargeTitles = true
        
        navigators.append(navigatorSurpriseMe)
        navigators.append(navigatorImBoring)
        navigators.append(navigatorUserConfig)
        return navigators
    }
    
}
