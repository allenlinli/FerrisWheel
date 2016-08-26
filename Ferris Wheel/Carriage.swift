//
//  Carriage.swift
//  Ferris Wheel
//
//  Created by allenlinli on 4/7/16.
//  Copyright © 2016 allenlinli. All rights reserved.
//

import Foundation
import UIKit

protocol CarriageDelegate: class {
    func carriageDidTapped(_ sender: Carriage?)
}

class Carriage: UIControl{
    var type: CarriageType!
    var carriageImageView: UIImageView!
    weak var delegate: CarriageDelegate?

    var titleLabel: UILabel!
    let TitleLabelSize = CGSize(width: 50, height: 10)
    
    init(frame: CGRect, type: CarriageType) {
        self.type = type
        
        let carriageImage = UIImage(named:type.getCarriageImageName())
        carriageImageView = UIImageView(image: carriageImage)
        titleLabel = UILabel(frame: CGRect(origin: CGPoint(x: 0,y: frame.height-4), size: TitleLabelSize))
        titleLabel.backgroundColor = UIColor.black
        titleLabel.text = type.getCarriageTitle()
        titleLabel.textColor = UIColor(red: 125.0/255.0, green: 125.0/255.0, blue: 125.0/255.0, alpha: 1)
        titleLabel.font = UIFont.systemFont(ofSize: 8.0, weight: TitleLabelSize.width)
        titleLabel.textAlignment = NSTextAlignment.center
        
        super.init(frame: frame)
        addSubview(carriageImageView)
        carriageImageView.addSubview(titleLabel)
        
        addTarget(self, action: #selector(Carriage.carriageTapped), for: UIControlEvents.touchDown)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func carriageTapped() {
        delegate?.carriageDidTapped(self)
    }
    
    func index () -> Int {
        return type.rawValue
    }
}

public enum CarriageType: Int {
    case rides = 0
    case showbags
    case plan
    case foodDrink
    case shopping
    case lifeStyle
    case tickets
    case search
    case info
    case win
    case maps
    case whatsOn
    
    public func getCarriageTitle() -> String {
        switch self {
        case .rides: return "Rides"
        case .showbags: return "Showbags"
        case .plan: return "Plan"
        case .foodDrink: return "Food & Drink"
        case .shopping: return "Shopping"
        case .lifeStyle: return "LifeStyle"
        case .tickets: return "Tickets"
        case .search: return "Search"
        case .info: return "Info"
        case .win: return "Win"
        case .maps: return "Maps"
        case .whatsOn: return "What's On"
        }
    }
    
    func getCarriageImageName() -> String {
        switch self {
        case .rides: return "Rides"
        case .showbags: return "Showbags"
        case .plan: return "Plan"
        case .foodDrink: return "FoodDrink"
        case .shopping: return "Shopping"
        case .lifeStyle: return "Shows"
        case .tickets: return "Tickets"
        case .search: return "Search"
        case .info: return "About"
        case .win: return "Win"
        case .maps: return "Maps"
        case .whatsOn: return "Program"
        }
    }
    
    public static let allValues = [rides, showbags, plan,foodDrink,shopping,lifeStyle,tickets,search,info,win,maps,whatsOn]
}
