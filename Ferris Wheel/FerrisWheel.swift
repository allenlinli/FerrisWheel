//
//  FerrisWheelViewController.swift
//  Ferris Wheel
//
//  Created by allenlinli on 4/7/16.
//  Copyright © 2016 allenlinli. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

protocol FerrisWheelDelegate {
    func ferrisWheelDidStartRotate()
    func ferrisWheelDidFinishRotate()
}

let WheelImageName: String = "wheel"


class FerrisWheel: UIControl{
    let wheelImageView: UIImageView!
    let carriages: [Carriage]!
    var ferrisWheelDidFinishRotateDelegate: FerrisWheelDelegate?
    var centre: CGPoint! {
        get {
            return wheelImageView.center
        }
    }
    
    //>> for rotating
    var startTransform: CGAffineTransform?
    var angleOfTouchFromWheelCentre: CGFloat?
    
    override init(frame: CGRect) {
        
        //>> setup carriages
        var tempCarriages: [Carriage] = []
        for type: CarriageType in CarriageType.allValues {
            let carriage: Carriage = Carriage(type: type)
            tempCarriages.append(carriage)
        }
        carriages = tempCarriages
        
        //>> setup wheelImageView
        let wheelImage = UIImage(named: WheelImageName)
        wheelImageView = UIImageView(image:wheelImage)
        
        super.init(frame: frame)
        
        addSubview(wheelImageView)
        
        wheelImageView.center = self.center
    }
    
    convenience init(frame: CGRect, delegate: FerrisWheelDelegate?) {
        self.init(frame: frame)
        ferrisWheelDidFinishRotateDelegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        let touchPoint = touch.locationInView(self)
        let distanceFromCentre = calculateDistanceFromCenter(touchPoint)
        let WheelOutterRadius = CGFloat(130.0)
        if distanceFromCentre > WheelOutterRadius {
            return false
        }
        
        startTransform = wheelImageView.transform
        angleOfTouchFromWheelCentre = calculateAngleOfTouchFromWheelCentreWithTouchPoint(touchPoint)
        
        return true
    }
    
    override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        let touchPoint = touch.locationInView(self)
        
        guard let uAngleOfTouchFromWheelCentre = angleOfTouchFromWheelCentre else { return false }
        let angleDifference = calculateAngleOfTouchFromWheelCentreWithTouchPoint(touchPoint) - uAngleOfTouchFromWheelCentre
        
        guard let uStartTransform = startTransform else {  return false }
        wheelImageView.transform = CGAffineTransformRotate(uStartTransform, -angleDifference);
        
        return true
    }
    
    override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
        
    }
    
    //>> helper methods
    func calculateDistanceFromCenter(point: CGPoint) -> CGFloat {
        let dx = point.x - centre.x
        let dy = point.y - centre.y
        return sqrt(dx*dx + dy*dy)
    }
    
    func calculateAngleOfTouchFromWheelCentreWithTouchPoint(point: CGPoint)-> CGFloat! {
        let dx = point.x - centre.x
        let dy = centre.y - point.y
    
        return atan2(dy,dx)
    }
}


