//
//  File.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 12/12/2021.
//

import Foundation
import UIKit
import Alamofire

class SupriseMeRouter: SurpriseMeRouterProtocol {
    weak var viewController: UIViewController?
    
    func goToCreateList(feeling: SurpriseMeFeeling, artists: [Artist?]) {
        var controller: UIViewController?
        if artists.count > 0 {
            controller =  CreatePlayListModule.build(feeling: feeling, artists: artists)
        } else {
            controller = EditFeelingArtistsModule.build(feeling: feeling)
        }
        guard let controller = controller else { return }

        viewController?.navigationController?.pushViewController(controller, animated: true)
    }
    
    func goToEditArtists(feeling: SurpriseMeFeeling) {
        let controller = EditFeelingArtistsModule.build(feeling: feeling)
        viewController?.navigationController?.pushViewController(controller, animated: true)
    }
    //TODO: Create a PlayList, take random atributes for category.
    //TODO: Play on Spotify. - i need deeplinks. 
}
