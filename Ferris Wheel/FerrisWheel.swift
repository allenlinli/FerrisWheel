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
let CarriageSize = CGSize(width: 50.0 , height: 50.0)

class FerrisWheel: UIControl{
    let wheelImageView: UIImageView!
    let carriages: [Carriage]!
    
    var ferrisWheelDidFinishRotateDelegate: FerrisWheelDelegate?
    
    // MARK: for counting degree
    var carriageCount = 12
    var eachCarriageAngle: CGFloat {
        get {
            return 360.0 / CGFloat(carriageCount)
        }
    }
    var wheelImageViewCentre: CGPoint { get { return wheelImageView.center } }
    let wheelRadius: CGFloat!
    let WheelRadiusIndent = CGFloat(25.0)
    var radius: CGFloat { get { return wheelRadius - WheelRadiusIndent} }
    func calculatePointFromRadiusFromWheelCentreWithRadian(radian: CGFloat) -> CGPoint {
        let dxFromWheelCentre = radius * cos(radian)
        let dyFromWheelCentre = radius * sin(radian)
        return CGPoint(x:wheelImageViewCentre.x + dxFromWheelCentre, y: wheelImageViewCentre.y + dyFromWheelCentre)
    }
    
    // MARK:  for rotating of wheel
    var startTransform: CGAffineTransform?
    var radianOfTouchFromWheelCentre: CGFloat?
    var carriagesCentres: [CGPoint]!
    let InitialRadianOffset: CGFloat = 0.39
    
    
    // MARK: init functions
    override init(frame: CGRect) {
        //>> setup wheelImageView
        let wheelImage = UIImage(named: WheelImageName)
        wheelImageView = UIImageView(image:wheelImage)
        wheelRadius = wheelImageView.frame.size.width / 2
        
        //>> setup carriages
        self.carriages = CarriageType.allValues.map { (type) -> Carriage in
            return Carriage(frame: CGRect(origin: CGPoint(x: 0,y: 0), size: CarriageSize), type: type)
        }
        
        super.init(frame: frame)
        
        addSubview(wheelImageView)
        
        placeCarriages()
    }
    
    convenience init(frame: CGRect, delegate: FerrisWheelDelegate?) {
        self.init(frame: frame)
        ferrisWheelDidFinishRotateDelegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UIControl Delegates
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        let touchPoint = touch.locationInView(self)
        let distanceFromCentre = calculateDistanceFromCenter(touchPoint)
        let WheelOutterRadius = CGFloat(130.0)
        if distanceFromCentre > WheelOutterRadius { return false }
        
        startTransform = wheelImageView.transform
        radianOfTouchFromWheelCentre = calculateRadianOfTouchFromWheelCentreWithTouchPoint(touchPoint)
        
        ferrisWheelDidFinishRotateDelegate?.ferrisWheelDidStartRotate()
        return true
    }
    
    override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        let touchPoint = touch.locationInView(self)
        
        guard let uRadianOfTouchFromWheelCentre = radianOfTouchFromWheelCentre else { return false }
        let radianDifference = calculateRadianOfTouchFromWheelCentreWithTouchPoint(touchPoint) - uRadianOfTouchFromWheelCentre
        
        guard let uStartTransform = startTransform else {  return false }
        wheelImageView.transform = CGAffineTransformRotate(uStartTransform, -radianDifference);
        
        placeCarriagesWithRadianDifference(radianDifference)
        
        return true
    }
    
    override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
        ferrisWheelDidFinishRotateDelegate?.ferrisWheelDidFinishRotate()
    }
    
    override func cancelTrackingWithEvent(event: UIEvent?) {
        ferrisWheelDidFinishRotateDelegate?.ferrisWheelDidFinishRotate()
    }
    
    // MARK: helper methods for rotating
    func placeCarriages() {
        placeCarriagesWithRadianDifference(0)
    }
    
    func placeCarriagesWithRadianDifference(dRadian: CGFloat) {
        for (index, carriage) in carriages.enumerate() {
            let radianForThisCarriage = CGFloat(index) * eachCarriageAngle / 180.0 * CGFloat(M_PI)
            carriage.center = calculatePointFromRadiusFromWheelCentreWithRadian(radianForThisCarriage+InitialRadianOffset-dRadian)
            if (carriage.superview == nil) { addSubview(carriage) }
        }
    }
    
    func calculateDistanceFromCenter(point: CGPoint) -> CGFloat {
        return calculateDistanceWith(point, point2: wheelImageViewCentre)
    }
    
    func calculateRadianOfTouchFromWheelCentreWithTouchPoint(point: CGPoint) -> CGFloat! {
        let dx = point.x - wheelImageViewCentre.x
        let dy = wheelImageViewCentre.y - point.y
    
        return atan2(dy,dx)
    }
}



