//
//  FerrisWheel+UIControl.swift
//  Ferris Wheel
//
//  Created by allenlinli on 4/14/16.
//  Copyright © 2016 allenlinli. All rights reserved.
//

import UIKit

extension FerrisWheel {
    // MARK: UIControl Delegates
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let beginTouchPoint = touch.location(in: self)
        let distanceFromCentre = HelperMethods.calculateDistanceWith(beginTouchPoint, point2: wheelImageViewCentre)
        let WheelOutterRadius = CGFloat(130.0)
        if distanceFromCentre > WheelOutterRadius { return false }
        
        radianOfBeginTouchPoint = radianWithPoint(beginTouchPoint)
        didStartRotate()
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchPoint = touch.location(in: self)
        
        let radianDifferenceFromBeginTouchPoint = radianWithPoint(touchPoint) - radianOfBeginTouchPoint!
        
        wheelImageView.transform = startTransform.rotated(by: -radianDifferenceFromBeginTouchPoint);
        
        lastRadianFromBeginTouchPoint = radianDifferenceFromBeginTouchPoint
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        didStopRotate()
        radianOfFirstCarriage -= lastRadianFromBeginTouchPoint
    }
    
    override func cancelTracking(with event: UIEvent?) {
        didStopRotate()
        radianOfFirstCarriage -= lastRadianFromBeginTouchPoint
    }
    
    func carriageDidTapped(_ carriage: Carriage?) {
        rotateCarriageToTop(carriage)
    }
}
