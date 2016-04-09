//
//  ViewController.swift
//  Ferris Wheel
//
//  Created by allenlinli on 4/7/16.
//  Copyright © 2016 allenlinli. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FerrisWheelDelegate {
    var ferrisWheel: FerrisWheel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(view.center)
        ferrisWheel = FerrisWheel(frame: view.frame, delegate: self)
        view.addSubview(ferrisWheel)
    }

    
    func ferrisWheelDidStartRotate(){
        
    }
    
    func ferrisWheelDidFinishRotate(){
        
    }
}

