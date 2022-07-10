//
//  FeelingCategories.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 19/02/2022.
//

import Foundation
import UIKit

enum PlayListTitle: String, CaseIterable {
    case IWantALightsaber = "I want a lightsaber!"
    case IWantToParty = "I want to party!"
    case SuitUp = "SUIT UP!"
    case ImThirsty = "Im thirsty"
    case ImDown = "Im down :/"
}

class FeelingCategories {
    
    static func getTitle(feeling: SurpriseMeFeeling ) -> String {
        switch feeling {
        case .IWantALightsaber:
            return "iWantALightsaber".localized()
        case .IWantToParty:
            return "iWantToParty".localized()
        case .SuitUp:
            return "suitUp".localized()
        case .ImThirsty:
            return "imThirsty".localized()
        case .ImDown:
            return "imDown".localized()
        }
    }
}
