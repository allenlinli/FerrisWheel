//
//  ShowInformationView.swift
//  Ferris Wheel
//
//  Created by allenlinli on 4/11/16.
//  Copyright © 2016 allenlinli. All rights reserved.
//

import UIKit

class ShowInformationView: UIView {
    var contentView: UIView!
    var menuButton: UIButton!
    var topBarView: UIView!
    
    convenience init(frame: CGRect, contentViewFrame: CGRect) {
        self.init(frame: frame)
        clipsToBounds = true
        
        contentView = UIView(frame: contentViewFrame)
        
        addSubview(contentView)
        
        topBarView = UIView(frame: CGRect(x: 0, y: 0, width: contentViewFrame.height, height: 44))
        topBarView.backgroundColor = UIColor.grayColor()
        
        let menuButtonImage = UIImage(named: "menubutton")
        menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 47, height: 47))
        menuButton.setImage(menuButtonImage, forState: UIControlState.Normal)
        contentView.addSubview(topBarView)
        topBarView.addSubview(menuButton)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
