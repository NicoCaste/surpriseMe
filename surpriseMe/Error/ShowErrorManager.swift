//
//  ShowErrorManager.swift
//  surpriseMe
//
//  Created by nicolas castello on 10/07/2022.
//

import Foundation

class ShowErrorManager {
    static func showErrorView(title: String, description: String) {
        let error = ErrorMessage(title: title, description: description)
        let userInfo = ["errorMessage" : error]
        NotificationCenter.default.post(name: NSNotification.Name.showErrorView, object: nil, userInfo: userInfo)
    }
}
