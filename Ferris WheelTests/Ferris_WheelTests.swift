//
//  Ferris_WheelTests.swift
//  Ferris WheelTests
//
//  Created by allenlinli on 4/9/16.
//  Copyright © 2016 allenlinli. All rights reserved.
//

import XCTest
import Foundation
import UIKit

@testable import Ferris_Wheel

class Ferris_WheelTests: XCTestCase {
    var ferrisWheel: FerrisWheel!
    
    override func setUp() {
        //!! test under iPhone 6
        super.setUp()
        let view = UIView(frame: CGRect(x: 0.0,y: 80.0,width: 320.0,height: 320.0))
        ferrisWheel = FerrisWheel(frame: view.frame, delegate: nil)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCarriagesTypesArray() {
        let carriagesTypesArray = ferrisWheel.carriages.map({ (carriage) -> CarriageType in
            return carriage.type
        })
        
        XCTAssert(carriagesTypesArray == CarriageType.allValues,"carriagesTypesArray: \(carriagesTypesArray)")
    }
    
    func testFerrisWheel() {
        XCTAssert(ferrisWheel.center == CGPoint(x: 160.0, y: 240.0), "ferrisWheel.center: \(ferrisWheel.center)")
        XCTAssert(ferrisWheel.frame == CGRect(x: 0,y: 80,width: 320, height: 320 ), "ferrisWheel.frame: \(ferrisWheel.frame)")
    }
    
    func testFerrisWheelImageVew() {
        XCTAssert(ferrisWheel.wheelImageView.frame == CGRect(x: 0,y: 0,width: 320, height: 320 ), "ferrisWheel.wheelImageView.frame: \(ferrisWheel.wheelImageView.frame)")
    }
    
    func testCalculateDistanceFromCenter() {

        let centre = ferrisWheel.wheelImageViewCentre
        let topPoint = CGPointMake(centre.x, 0)
        let dist1 = ferrisWheel.calculateDistanceFromCenter(topPoint)
        XCTAssert(dist1 == 160, "\n dist1: \(dist1)")
        
        let leftPoint = CGPointMake(0, centre.y)
        let dist2 = ferrisWheel.calculateDistanceFromCenter(leftPoint)
        XCTAssert(dist2 == 160, "\n dist2: \(dist2)")
        
        let rightPoint = CGPointMake(375, centre.y)
        let dist3 = ferrisWheel.calculateDistanceFromCenter(rightPoint)
        XCTAssert(dist3 == 215.0, "\n dist3: \(dist3)")
        
        let topRightPoint = CGPointMake(centre.x+3, centre.y+4)
        let dist4 = ferrisWheel.calculateDistanceFromCenter(topRightPoint)
        XCTAssert(dist4 == 5, "\n dist4: \(dist1)")
    }
    
    func testCalculateAngleOfTouchFromWheelCentreWithTouchPoint() {
        // Radian * 180 / pi == Degree
        let topPoint = CGPointMake(ferrisWheel.wheelImageViewCentre.x, 0)
        let angle1 = ferrisWheel.calculateRadianOfTouchFromWheelCentreWithTouchPoint(topPoint)
        XCTAssert(angle1 == atan2(1,0), "angle1: \(angle1)")
        
        let rightPoint = CGPointMake(375, ferrisWheel.wheelImageViewCentre.y)
        let angle2 = ferrisWheel.calculateRadianOfTouchFromWheelCentreWithTouchPoint(rightPoint)
        XCTAssert(Float(angle2) == 0.0, "Float(angle2): \(Float(angle2))")
    }
    
}
