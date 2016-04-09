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
    var wheelCentre: CGPoint! {
        get {
            return wheelImageView.center
        }
    }
    
    //>> for rotating
    var startTransform: CGAffineTransform?
    var angleOfTouchFromWheelCentre: CGFloat?
    
    override init(frame: CGRect) {
        //>> setup wheelImageView
        let wheelImage = UIImage(named: WheelImageName)
        wheelImageView = UIImageView(image:wheelImage)
        
        //>> setup carriages
        var tempCarriages: [Carriage] = []
        for type: CarriageType in CarriageType.allValues {
            let carriage: Carriage = Carriage(frame: CGRect(x: 0.0,y: 0.0,width: 50.0,height: 50.0), type: type)
            tempCarriages.append(carriage)
        }
        carriages = tempCarriages
        
        super.init(frame: frame)
        
        addSubview(wheelImageView)
        
        //>> calculate carriages positions
        let carriageCount = 12
        let eachCarriageAngle = 360.0 / CGFloat(carriageCount)
        let wheelRadius = wheelImageView.frame.size.width / 2
        let wheelRadiusIndent = CGFloat(20.0)
        
        let radius = wheelRadius - wheelRadiusIndent
        
        for (index, carriage) in carriages.enumerate() {
            let radian = CGFloat(index) * eachCarriageAngle / 180.0 * CGFloat(M_PI)
            let dxFromWheelCentre = CGFloat(radius) * cos(radian)
            let dyFromWheelCentre = CGFloat(radius) * sin(radian)
            let carriageCentre = CGPoint(x:wheelCentre.x + dxFromWheelCentre, y: wheelCentre.y + dyFromWheelCentre)
            carriage.center = carriageCentre
            wheelImageView.addSubview(carriage)
        }
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
        if distanceFromCentre > WheelOutterRadius { return false }
        
        startTransform = wheelImageView.transform
        angleOfTouchFromWheelCentre = calculateAngleOfTouchFromWheelCentreWithTouchPoint(touchPoint)
        
        ferrisWheelDidFinishRotateDelegate?.ferrisWheelDidStartRotate()
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
        ferrisWheelDidFinishRotateDelegate?.ferrisWheelDidFinishRotate()
    }
    
    override func cancelTrackingWithEvent(event: UIEvent?) {
        ferrisWheelDidFinishRotateDelegate?.ferrisWheelDidFinishRotate()
    }
    
    //>> helper methods
    func calculateDistanceFromCenter(point: CGPoint) -> CGFloat {
        let dx = point.x - wheelCentre.x
        let dy = point.y - wheelCentre.y
        return sqrt(dx*dx + dy*dy)
    }
    
    func calculateAngleOfTouchFromWheelCentreWithTouchPoint(point: CGPoint)-> CGFloat! {
        let dx = point.x - wheelCentre.x
        let dy = wheelCentre.y - point.y
    
        return atan2(dy,dx)
    }
}

extension Double {
    var degreesToRadians: Double { return self * M_PI / 180 }
    var radiansToDegrees: Double { return self * 180 / M_PI }
}


