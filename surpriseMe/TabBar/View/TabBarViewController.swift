//
//  TabBarViewController.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 11/12/2021.
//

import UIKit

class TabBarViewController: UITabBarController, TabBarViewControllerProtocol {
    var presenter: TabBarPresenterProtocol?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showTabBar()
    }
    
    func showTabBar() {
        guard let presenter = presenter else { return }
        let navigators = presenter.showNavigators()
        setViewControllers(navigators, animated: false)
    }
}
