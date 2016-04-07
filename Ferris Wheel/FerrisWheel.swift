//
//  FerrisWheelViewController.swift
//  Ferris Wheel
//
//  Created by allenlinli on 4/7/16.
//  Copyright © 2016 allenlinli. All rights reserved.
//

import Foundation
import UIKit

protocol ferrisWheelDidFinishRotateDelegate {
    func ferrisWheelDidFinishRotate()
}



let carriageTitles = ["Rides", "Showbags","Plan","Food & Drink", "Shopping", "LifeStyle", "Tickets", "Search", "Info", "Win", "Maps", "What's On"]
//let  = ["Rides":[
//    ]]



class FerrisWheel {
    let radius: Double!
    let wheelImageView: UIImageView!
    let carriages: [Carriage]!
    var ferrisWheelDidFinishRotateDelegate: UIViewController?
    
    //?? How about anyObject as a protocol
    init() {
        self.radius = 30
//        self.wheelImageView = UIImageView(image: wheelImage)
        
        let defaultCarriagesCount: Int = 12
        
        
        self.ferrisWheelDidFinishRotateDelegate = nil
    }
    
//    init(wheelImage: UIImage, radius: Double, carriages:[Carriage], delegate: AnyObject) {
//    }
    
    func placeCarriages() {
        
    }
    
    func rotate() {
        
    }
    
    func carriageIsChoosed(carriage: Carriage) {
        
    }
    
    
}