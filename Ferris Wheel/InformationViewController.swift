//
//  InformationViewController.swift
//  Ferris Wheel
//
//  Created by allenlinli on 4/12/16.
//  Copyright © 2016 allenlinli. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController {
    var whiteBackgroundView: UIView!
    var orangeBackgroundView: UIView!
    var carriage: Carriage?
    
    override func viewDidLoad() {
        let grayBackgroundColor = UIColor(red: 74.0/255.0 , green: 74.0/255.0, blue: 74.0/255.0, alpha: 1)
        view.backgroundColor = grayBackgroundColor
        
        let topBarHeight = 50.0 as CGFloat
        whiteBackgroundView = UIView(frame: CGRect(x: 0, y: topBarHeight, width: view.frame.width, height: view.frame.height-topBarHeight))
        orangeBackgroundView = UIView(frame: CGRect(x: 0, y: topBarHeight, width: view.frame.width, height: view.frame.height-topBarHeight))
        
        view.addSubview(whiteBackgroundView)
        view.addSubview(orangeBackgroundView)
        
        
    }
    
    func menuBarButtonPressed() {
        
    }
}
