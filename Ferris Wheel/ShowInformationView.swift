//
//  ShowInformationView.swift
//  Ferris Wheel
//
//  Created by allenlinli on 4/11/16.
//  Copyright © 2016 allenlinli. All rights reserved.
//

import UIKit

class ShowInformationView: UIView {
    var contentView: UIView?
    
    convenience init(frame: CGRect, contentViewFrame: CGRect) {
        self.init(frame: frame)
        backgroundColor = UIColor.purpleColor()
        
        contentView = UIView(frame: contentViewFrame)
        guard let uContentView = contentView else {
            fatalError("")
        }
        addSubview(uContentView)
        
        let topBarView = UIView(frame: CGRect(x: 0, y: 0, width: contentViewFrame.height, height: 44))
        uContentView.addSubview(topBarView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
