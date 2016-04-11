//
//  ShowInformationView.swift
//  Ferris Wheel
//
//  Created by allenlinli on 4/11/16.
//  Copyright © 2016 allenlinli. All rights reserved.
//

import UIKit

protocol MenuButtonDelegate: class{
    func menuButtonTapped()
}

class ShowInformationView: UIView {
    var contentView: UIView!
    var menuButton: UIButton!
    var whiteView: UIView!
    var orangeView: UIView!
    var menuButtonDelegate: MenuButtonDelegate?
    let TopBarHeight: CGFloat = 50
    
    convenience init(frame: CGRect, contentViewFrame: CGRect, delegate: MenuButtonDelegate?) {
        self.init(frame: frame)
        print("contentViewFrame: \(contentViewFrame)")
        
        clipsToBounds = true
        backgroundColor = UIColor(red: 74.0/255.0, green: 74.0/255.0, blue: 74.0/255.0, alpha: 1)
        contentView = UIView(frame: contentViewFrame)
        
        whiteView = UIView(frame: CGRect(x: CGFloat(0.0),y: TopBarHeight,width: contentViewFrame.width,height: contentViewFrame.height-TopBarHeight))
        whiteView.backgroundColor = UIColor.whiteColor()
        whiteView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2/100))
        
        orangeView = UIView(frame: CGRect(x: CGFloat(0.0),y: TopBarHeight,width: contentViewFrame.width,height: contentViewFrame.height-TopBarHeight))
        orangeView.backgroundColor = UIColor(red: 236.0/255.0, green: 97.0/255.0, blue: 51.0/255.0, alpha: 1)
        orangeView.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_2/100))
        
        let menuButtonImage = UIImage(named: "menubutton")
        menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 47, height: 47))
        menuButton.setImage(menuButtonImage, forState: UIControlState.Normal)
        menuButtonDelegate = delegate
        menuButton.addTarget(menuButtonDelegate!, action: #selector(ViewController.menuButtonTapped), forControlEvents: UIControlEvents.TouchDown)
        
        addSubview(contentView)
        contentView.addSubview(orangeView)
        contentView.addSubview(whiteView)
        contentView.addSubview(menuButton)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
