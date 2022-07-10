//
//  SurpriseMeInteractor.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 12/12/2021.
//

import Foundation

enum SurpriseMeFeeling: Int, CaseIterable {
    case IWantALightsaber
    case IWantToParty
    case SuitUp
    case ImThirsty
    case ImDown
}

class SurpriseMeInteractor: SurpriseMeInteractorProtocol {
    var presenter: SurpriseMePresenterProtocol?

}
