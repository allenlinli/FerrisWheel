//
//  HelperMethods.swift
//  Ferris Wheel
//
//  Created by allenlinli on 4/10/16.
//  Copyright © 2016 allenlinli. All rights reserved.
//

import Foundation
import UIKit

struct HelperMethods {
    static func calculateDistanceWith(_ point1: CGPoint, point2: CGPoint) -> CGFloat {
        let dx = point1.x - point2.x
        let dy = point1.y - point2.y
        return sqrt(dx*dx + dy*dy)
    }
}
