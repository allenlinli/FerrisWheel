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
        let view = UIView(frame: CGRectMake(0,0,375,667))
        ferrisWheel = FerrisWheel(frame: view.frame, delegate: nil)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    let ferrisWheelCentrePoint = CGPoint(x: 187.5, y: 333.5)
    
    func testFerrisWheelCentre() {
        XCTAssert(ferrisWheel.centre == CGPoint(x: 187.5, y: 333.5))
    }
    
    func testCalculateDistanceFromCenter() {
        let topPoint = CGPointMake(ferrisWheelCentrePoint.x, 0)
        let dist1 = ferrisWheel.calculateDistanceFromCenter(topPoint)
        XCTAssert(dist1 == 333.5)
        
        let leftPoint = CGPointMake(0, ferrisWheelCentrePoint.y)
        let dist2 = ferrisWheel.calculateDistanceFromCenter(leftPoint)
        XCTAssert(dist2 == 187.5)
        
        let rightPoint = CGPointMake(375, ferrisWheelCentrePoint.y)
        let dist3 = ferrisWheel.calculateDistanceFromCenter(rightPoint)
        XCTAssert(dist3 == 187.5)
        
        let topRightPoint = CGPointMake(ferrisWheelCentrePoint.x+3, ferrisWheelCentrePoint.y+4)
        let dist4 = ferrisWheel.calculateDistanceFromCenter(topRightPoint)
        XCTAssert(dist4 == 5)
    }
    
    
    func testATan2() {
        print("atan2 should be: \(atan2(1.0,1.0))")
        XCTAssert( atan2(1.0,1.0) == 0.785398163397448)
    }
    
    func testCalculateAngleOfTouchFromWheelCentreWithTouchPoint() {
        
        // Radian * 180 / pi == Degree
        let topPoint = CGPointMake(ferrisWheelCentrePoint.x, 0)
        let angle1 = ferrisWheel.calculateAngleOfTouchFromWheelCentreWithTouchPoint(topPoint)
        print("should be angle1: \(angle1)")
        XCTAssert(angle1 == sin(0))
        
        let rightPoint = CGPointMake(375, ferrisWheelCentrePoint.y)
        let angle2 = ferrisWheel.calculateAngleOfTouchFromWheelCentreWithTouchPoint(rightPoint)
        XCTAssert(Float(angle2) == 0.0)
    }
    
}
