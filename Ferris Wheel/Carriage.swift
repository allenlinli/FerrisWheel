//
//  Carriage.swift
//  Ferris Wheel
//
//  Created by allenlinli on 4/7/16.
//  Copyright © 2016 allenlinli. All rights reserved.
//

import Foundation
import UIKit

public enum CarriageType {
    case Rides
    case Showbags
    case Plan
    case FoodDrink
    case Shopping
    case LifeStyle
    case Tickets
    case Search
    case Info
    case Win
    case Maps
    case WhatsOn
    
    public func getCarriageTitle() -> String {
        switch self {
        case Rides: return "Rides"
        case Showbags: return "Showbags"
        case Plan: return "Plan"
        case FoodDrink: return "Food & Drink"
        case Shopping: return "Shopping"
        case LifeStyle: return "LifeStyle"
        case Tickets: return "Tickets"
        case Search: return "Search"
        case Info: return "Info"
        case Win: return "Win"
        case Maps: return "Maps"
        case WhatsOn: return "What's On"
        }
    }
    
    func getCarriageImageName() -> String {
        switch self {
        case Rides: return "Rides"
        case Showbags: return "Showbags"
        case Plan: return "Plan"
        case FoodDrink: return "FoodDrink"
        case Shopping: return "Shopping"
        case LifeStyle: return "Shows"
        case Tickets: return "Tickets"
        case Search: return "Search"
        case Info: return "About"
        case Win: return "Win"
        case Maps: return "Maps"
        case WhatsOn: return "Program"
        }
    }
    
    public static let allValues = [Showbags, Plan,FoodDrink,Shopping,LifeStyle,Tickets,Search,Info,Win,Maps,WhatsOn,Rides]
}



public class Carriage: UIControl{
    var type: CarriageType!
    var carriageImageView: UIImageView!

    var titleLabel: UILabel!
    let TitleLabelSize = CGSize(width: 50, height: 10)
    
    init(frame: CGRect, type: CarriageType) {
        self.type = type
        
        let carriageImage = UIImage(named:type.getCarriageImageName())
        carriageImageView = UIImageView(image: carriageImage)
        titleLabel = UILabel(frame: CGRect(origin: CGPoint(x: 0,y: frame.height-4), size: TitleLabelSize))
        titleLabel.backgroundColor = UIColor.blackColor()
        titleLabel.text = type.getCarriageTitle()
        titleLabel.textColor = UIColor(red: 125.0/255.0, green: 125.0/255.0, blue: 125.0/255.0, alpha: 1)
        titleLabel.font = UIFont.systemFontOfSize(8.0, weight: TitleLabelSize.width)
        titleLabel.textAlignment = NSTextAlignment.Center
        
        super.init(frame: frame)
        addSubview(carriageImageView)
        carriageImageView.addSubview(titleLabel)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}