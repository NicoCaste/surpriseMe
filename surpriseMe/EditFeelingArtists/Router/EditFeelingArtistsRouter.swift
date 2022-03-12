//
//  EditFeelingArtistsRouter.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 19/02/2022.
//
import UIKit

class EditFeelingArtistsRouter: EditFeelingArtistsRouterProtocol {
    weak var viewController: UIViewController?
    
    func goToCreateList(feeling: SurpriseMeFeeling, artists: [Artist?]) {
        var controller: UIViewController? = nil
        if artists.count > 0 {
            controller =  CreatePlayListModule.build(feeling: feeling, artists: artists)
        }
        guard let controller = controller else { return }

        viewController?.navigationController?.pushViewController(controller, animated: true)
    }
}
