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

protocol FerrisWheelDelegate: class {
    func ferrisWheelDidStartRotate()
    func ferrisWheelDidStopRotate()
    func openCarriage(_ carriage: Carriage!)
}

let WheelImageName: String = "wheel"
let CarriageSize = CGSize(width: 50.0 , height: 50.0)

private var myContext = 0

class FerrisWheel: UIControl, CarriageDelegate{
    let wheelImageView: UIImageView!
    let carriages: [Carriage]!
    
    weak var ferrisWheelDelegate: FerrisWheelDelegate?
    
    // MARK: for counting degree
    var carriageCount = 12
    var eachCarriageRadian: CGFloat { get { return CGFloat(M_PI * 2) / CGFloat(carriageCount) } }
    var wheelImageViewCentre: CGPoint { get { return wheelImageView.center } }
    let wheelRadius: CGFloat!
    let WheelRadiusIndent = 25.0 as CGFloat
    var radius: CGFloat { get { return wheelRadius - WheelRadiusIndent} }
    
    // MARK:  for rotating of wheel
    var carriahesPoints: [CGPoint]!
    
    var startTransform: CGAffineTransform!
    var radianOfBeginTouchPoint: CGFloat?
    var carriagesCentres: [CGPoint]!
    //First Carriage is "Rides"
    let initialRadianOfFirstCarriage: CGFloat = -1.7
    var radianOfFirstCarriage: CGFloat
    var lastRadianFromBeginTouchPoint: CGFloat = 0.0
    var pointOfFirstCarriageOnWheelImageView: CGPoint!
    
    // MARK: init functions
    override init(frame: CGRect) {
        let wheelImage = UIImage(named: WheelImageName)
        wheelImageView = UIImageView(image:wheelImage)
        wheelRadius = wheelImageView.frame.size.width / 2
        startTransform = wheelImageView.transform
        self.carriages = CarriageType.allValues.map { (type) -> Carriage in
            return Carriage(frame: CGRect(origin: CGPoint(x: 0,y: 0), size: CarriageSize), type: type)
        }
        
        radianOfFirstCarriage = initialRadianOfFirstCarriage
        
        super.init(frame: frame)
        
        addSubview(wheelImageView)
        
        //>> Places Carirages
        carriahesPoints = carriages.map { (carriage: Carriage) -> CGPoint in
            let radianForThisCarriage = CGFloat(carriage.index()) * eachCarriageRadian + initialRadianOfFirstCarriage
            return pointWithRadian(radianForThisCarriage)
        }
        for carriage in carriages {
            let pointOfThisCarriageOnView = carriahesPoints[carriage.index()]
            carriage.center = pointOfThisCarriageOnView
            if carriage.superview == nil {
                addSubview(carriage)
            }
        }
        
        wheelImageView.addObserver(self,
                             forKeyPath: "transform",
                             options: .new,
                             context: &myContext)
    }
    
    convenience init(frame: CGRect, delegate: FerrisWheelDelegate?) {
        self.init(frame: frame)
        ferrisWheelDelegate = delegate
        for tCarriage in carriages {
            tCarriage.delegate = self
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: About Rotate
    var rotateTimer: Timer?
    var radianDifferenceToRotate: CGFloat?
    var rotatingRadianAmount: CGFloat? = 0
    //>> radianPerTimeInterval=0.03, rotatingTimeInterval =0.03
    let radianPerTimeInterval: CGFloat = 0.02 //Rotating Speed
    let rotatingTimeInterval: Double = 0.000003
    var choosedCarriage: Carriage!
    func rotateCarriageToTop(_ carriage: Carriage!) {
        isUserInteractionEnabled = false
        rotatingRadianAmount = 0
        choosedCarriage = carriage
        didStartRotate()
        let choosedCarriagePoint = wheelImageView.convert(carriahesPoints[choosedCarriage!.index()], to: self)
        
        let TwoPI = CGFloat(M_PI) * 2
        let choosedCarriageRadian = radianWithPoint(choosedCarriagePoint)
        let clockWiseRadianFromRight = -choosedCarriageRadian
        var clockWiseRadianFromTop = clockWiseRadianFromRight + TwoPI/4
        
        if clockWiseRadianFromTop >= CGFloat(0) {
            while clockWiseRadianFromTop >= TwoPI {
                clockWiseRadianFromTop -= TwoPI
            }
        }
        else {
            while clockWiseRadianFromTop < CGFloat(0) {
                clockWiseRadianFromTop += TwoPI
            }
        }
        
        let positiveClockWiseRadianFromTop = clockWiseRadianFromTop
        radianDifferenceToRotate = CGFloat(M_PI) * 2 - positiveClockWiseRadianFromTop
    
        rotateTimer = Timer.scheduledTimer(timeInterval: rotatingTimeInterval, target: self, selector: #selector(rotateForATimeInterval), userInfo: nil, repeats: true)
        rotateTimer!.fire()
    }
    
    func rotateForATimeInterval() {
        wheelImageView.transform = startTransform.rotated(by: rotatingRadianAmount!);
        
        rotatingRadianAmount! += radianPerTimeInterval
        let shouldStop = radianDifferenceToRotate! - rotatingRadianAmount! <= 0
        if shouldStop {
            print("")
            
            
            didStopRotate()
            rotatingRadianAmount = 0
            radianDifferenceToRotate = 0
            startTransform = wheelImageView.transform
            rotateTimer?.invalidate()
            rotateTimer = nil
            ferrisWheelDelegate?.openCarriage(choosedCarriage)
            choosedCarriage = nil
            isUserInteractionEnabled = true
        }
    }
    
    func didStartRotate() {
        startTransform = wheelImageView.transform
        ferrisWheelDelegate?.ferrisWheelDidStartRotate()
    }
    
    func didStopRotate() {
        startTransform = wheelImageView.transform
        ferrisWheelDelegate?.ferrisWheelDidStopRotate()
    }
    
    
    // MARK: About Radian
    func radianWithPoint(_ point: CGPoint) -> CGFloat! {
        let dx = point.x - wheelImageViewCentre.x
        let dy = wheelImageViewCentre.y - point.y
        return atan2(dy,dx)
    }
    
    // MARK: About Point and Distance
    func pointWithRadian(_ radian: CGFloat) -> CGPoint {
        let dxFromWheelCentre = radius * cos(radian)
        let dyFromWheelCentre = radius * sin(radian)
        return CGPoint(x:wheelImageViewCentre.x + dxFromWheelCentre, y: wheelImageViewCentre.y + dyFromWheelCentre)
    }
    
    // MARK: KVO
    override func observeValue(forKeyPath keyPath: String?,
                                         of object: Any?,
                                                  change: [String : Any]?,
                                                  context: UnsafeMutableRawPointer?)
    {
        if let _ = change , context == &myContext {
            for carriage in carriages {
                let pointOfThisCarriageOnView = wheelImageView.convert(carriahesPoints[carriage.index()], to: self)
                carriage.center = pointOfThisCarriageOnView
            }
        }
    }
}
