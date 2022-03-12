//
//  EditFeelingArtistsModule.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 19/02/2022.
//

import UIKit

final class EditFeelingArtistsModule {
    
    static func build(feeling: SurpriseMeFeeling) -> UIViewController {
        let view = EditFeelingArtistsViewController()
        let interactor = EditFeelingArtistsInteractor()
        let router = EditFeelingArtistsRouter()
        let presenter = EditFeelingArtistsPresenter()
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.feeling = feeling
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        return view
    }
}
