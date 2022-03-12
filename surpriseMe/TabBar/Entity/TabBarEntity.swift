//
//  TabBarEntity.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 11/12/2021.
//

import UIKit

protocol TabBarViewControllerProtocol {
    
}
protocol TabBarInteractorProtocol {
    
}
protocol TabBarPresenterProtocol {
    func showNavigators() -> [UINavigationController]
}
protocol TabBarRouterProtocol {
    func goToImBoring() -> UINavigationController
    func goToSurpriseMe() -> UINavigationController
    func goToUserConfig() -> UINavigationController
}
