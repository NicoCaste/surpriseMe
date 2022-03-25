//
//  CGFloatExtension.swift
//  surpriseMe
//
//  Created by nicolas castello on 25/03/2022.
//

import UIKit

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat(Double.pi) / 180.0
    }
}
