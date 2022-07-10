//
//  UIViewExtension.swift
//  surpriseMe
//
//  Created by nicolas castello on 10/07/2022.
//

import Foundation
import UIKit

extension UIView {
    func gradientBackground(topColor: CGColor, bottomColor: CGColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor, bottomColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at:0)
    }
}
