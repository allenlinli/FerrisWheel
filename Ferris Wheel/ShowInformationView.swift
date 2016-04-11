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
    var titleLabel: UILabel!
    var menuButtonDelegate: MenuButtonDelegate?
    let TopBarHeight: CGFloat = 50
    
    convenience init(frame: CGRect, contentViewFrame: CGRect, delegate: MenuButtonDelegate?) {
        self.init(frame: frame)
        clipsToBounds = true
        
        //this is work around. too many magic number.
        backgroundColor = UIColor(red: 74.0/255.0, green: 74.0/255.0, blue: 74.0/255.0, alpha: 1)
        
        let adjustFrame = CGRect(x: contentViewFrame.origin.x, y: contentViewFrame.origin.y, width: contentViewFrame.width, height: contentViewFrame.height)
        contentView = UIView(frame: adjustFrame)
        
        whiteView = UIView(frame: CGRect(x: CGFloat(0.0),y: TopBarHeight+8,width: contentViewFrame.width,height: contentViewFrame.height-TopBarHeight))
        whiteView.backgroundColor = UIColor.whiteColor()
        whiteView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2/100))
        
        orangeView = UIView(frame: CGRect(x: CGFloat(0.0),y: TopBarHeight+8,width: contentViewFrame.width,height: contentViewFrame.height-TopBarHeight))
        orangeView.backgroundColor = UIColor(red: 236.0/255.0, green: 97.0/255.0, blue: 51.0/255.0, alpha: 1)
        orangeView.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_2/100))
        
        let menuButtonImage = UIImage(named: "menubutton")
        menuButton = UIButton(frame: CGRect(x: 4, y: 4, width: 50, height: 50))
        menuButton.setImage(menuButtonImage, forState: UIControlState.Normal)
        menuButtonDelegate = delegate
        menuButton.addTarget(menuButtonDelegate!, action: #selector(ViewController.menuButtonTapped), forControlEvents: UIControlEvents.TouchDown)
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: 8, width: contentViewFrame.width-16, height: 50))
        titleLabel.text = "Show Information"
        titleLabel.textAlignment = NSTextAlignment.Right
        titleLabel.textColor = UIColor(red: 173/255.0, green: 173/255.0, blue: 173/255.0, alpha: 1)
        titleLabel.font = UIFont(name: titleLabel.font.fontName, size: 16)
        
        addSubview(contentView)
        contentView.addSubview(orangeView)
        contentView.addSubview(whiteView)
        contentView.addSubview(menuButton)
        contentView.addSubview(titleLabel)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
