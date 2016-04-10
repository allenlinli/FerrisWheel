//
//  Double+Radian.swift
//  Ferris Wheel
//
//  Created by allenlinli on 4/10/16.
//  Copyright © 2016 allenlinli. All rights reserved.
//

import Foundation

extension Double {
    var degreesToRadians: Double { return self * M_PI / 180 }
    var radiansToDegrees: Double { return self * 180 / M_PI }
}
