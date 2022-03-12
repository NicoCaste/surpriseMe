//
//  MainCoordinatorProtocol.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 11/12/2021.
//

import Foundation

import UIKit

protocol MainProtocolCoordinator {
    var childCoordinators: [MainProtocolCoordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
