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
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        let beginTouchPoint = touch.locationInView(self)
        let distanceFromCentre = HelperMethods.calculateDistanceWith(beginTouchPoint, point2: wheelImageViewCentre)
        let WheelOutterRadius = CGFloat(130.0)
        if distanceFromCentre > WheelOutterRadius { return false }
        
        radianOfBeginTouchPoint = radianWithPoint(beginTouchPoint)
        didStartRotate()
        return true
    }
    
    override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        let touchPoint = touch.locationInView(self)
        
        let radianDifferenceFromBeginTouchPoint = radianWithPoint(touchPoint) - radianOfBeginTouchPoint!
        
        wheelImageView.transform = CGAffineTransformRotate(startTransform, -radianDifferenceFromBeginTouchPoint);
        
        lastRadianFromBeginTouchPoint = radianDifferenceFromBeginTouchPoint
        return true
    }
    
    override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
        didStopRotate()
        radianOfFirstCarriage -= lastRadianFromBeginTouchPoint
    }
    
    override func cancelTrackingWithEvent(event: UIEvent?) {
        didStopRotate()
        radianOfFirstCarriage -= lastRadianFromBeginTouchPoint
    }
    
    func carriageDidTapped(carriage: Carriage?) {
        rotateCarriageToTop(carriage)
    }
}