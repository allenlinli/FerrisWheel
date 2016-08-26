//
//  InformationViewController.swift
//  Ferris Wheel
//
//  Created by allenlinli on 4/12/16.
//  Copyright © 2016 allenlinli. All rights reserved.
//

import UIKit

protocol InformationViewControllerDelegate: class{
    func menuButtonPressed(_ sender: InformationViewController?)
}

class InformationViewController: UIViewController {
    var carriage: Carriage?
    var whiteBackgroundView: UIView!
    var orangeBackgroundView: UIView!
    var menuButton: UIButton!
    var titleLabel: UILabel!
    var informationViewControllerDelegate: InformationViewControllerDelegate?
    
    // MARK: CONSTANTS
    let topBarHeight = 60.0 as CGFloat
    let grayBackgroundColor = UIColor(red: 74.0/255.0 , green: 74.0/255.0, blue: 74.0/255.0, alpha: 1)
    let rotateBackgroundViewRadian = CGFloat(M_PI_2/120.0)
    let orangeBackgroundViewColor = UIColor(red: 236/255.0, green: 97/255.0, blue: 51/255.0, alpha: 1)
    let topBarIndent = 4.0 as CGFloat
    let titleLabelTextColor = UIColor(red: 173/255.0, green: 173/255.0, blue: 173/255.0, alpha: 1)
    
    override func viewDidLoad() {
        view.backgroundColor = grayBackgroundColor
        
        whiteBackgroundView = UIView(frame: CGRect(x: 0, y: topBarHeight, width: view.frame.width, height: view.frame.height-topBarHeight))
        orangeBackgroundView = UIView(frame: CGRect(x: 0, y: topBarHeight, width: view.frame.width, height: view.frame.height-topBarHeight))
        
        whiteBackgroundView.transform = CGAffineTransform(rotationAngle: rotateBackgroundViewRadian)
        orangeBackgroundView.transform = CGAffineTransform(rotationAngle: CGFloat(-rotateBackgroundViewRadian))
        
        whiteBackgroundView.backgroundColor = UIColor.white
        orangeBackgroundView.backgroundColor = orangeBackgroundViewColor
        
        let menuButtonImage = UIImage(named: "menubutton")
        menuButton = UIButton(frame: CGRect(x: topBarIndent, y: topBarIndent, width: 50, height: 50))
        menuButton.setImage(menuButtonImage, for: UIControlState())
        if let delegate = informationViewControllerDelegate {
            menuButton.addTarget(delegate, action: Selector("menuButtonPressed:"), for: UIControlEvents.touchUpInside)
        }
        
        titleLabel = UILabel(frame: CGRect(x: topBarIndent, y: topBarIndent, width: view.frame.width-topBarIndent*2, height: topBarHeight))
        titleLabel.text = "Show Information"
        titleLabel.textAlignment = NSTextAlignment.right
        titleLabel.textColor = titleLabelTextColor
        
        view.addSubview(orangeBackgroundView)
        view.addSubview(whiteBackgroundView)
        view.addSubview(menuButton)
        view.addSubview(titleLabel)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .lightContent
    }
}
