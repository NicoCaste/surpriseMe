//
//  ActivityIndicator.swift
//  surpriseMe
//
//  Created by Nicolas Castello Luro on 11/03/2022.
//

import Foundation
import UIKit

class ActivityIndicatorFactory {
    private let myView: UIView
    private var activityIndicator = UIActivityIndicatorView(style: .large)
    
    init(view: UIView) {
        self.myView = view
        createActivityIndicator()
    }
    
    func showActivityIndicator(isHide: Bool) {
        (isHide) ? activityIndicator.stopAnimating() : activityIndicator.startAnimating()
    }
    
    private func createActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        myView.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: myView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: myView.centerYAnchor).isActive = true
    }
}
