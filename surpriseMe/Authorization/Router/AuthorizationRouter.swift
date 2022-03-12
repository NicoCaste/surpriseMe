//
//  AuthorizationRouter.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 11/12/2021.
//

import Foundation
import UIKit

class AuthorizationRouter: AuthorizationRouterProtocol {
    weak var viewController: UIViewController?
    
    func goToRootView() {
        viewController?.navigationController?.popToRootViewController(animated: true)
    }
}
