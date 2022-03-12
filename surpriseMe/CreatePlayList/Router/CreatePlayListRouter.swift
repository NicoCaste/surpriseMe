//
//  CreatePlayListRouter.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 13/12/2021.
//

import Foundation
import UIKit

class CreatePlayListRouter: CreatePlayListRouterProtocol {
    var viewController: UIViewController?
    
    func goToSorpriseMe() {
        let controller = SurpriseMeModule.build()
        viewController?.navigationController?.pushViewController(controller, animated: false )
    }
}
    
