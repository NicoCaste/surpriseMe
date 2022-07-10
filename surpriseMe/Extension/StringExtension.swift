//
//  StringExtension.swift
//  surpriseMe
//
//  Created by nicolas castello on 10/07/2022.
//

import Foundation

extension String {
    func localized () -> String {
        return NSLocalizedString(self, comment: "")
    }
}
