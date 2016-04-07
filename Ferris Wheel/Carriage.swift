//
//  Carriage.swift
//  Ferris Wheel
//
//  Created by allenlinli on 4/7/16.
//  Copyright © 2016 allenlinli. All rights reserved.
//

import Foundation
import UIKit

enum CarriageType {
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
    
    func getCarriageTitle() -> CarriageTitle {
        switch self {
        case Rides: return CarriageTitle.Rides
        case Showbags: return CarriageTitle.Showbags
        case Plan: return CarriageTitle.Plan
        case FoodDrink: return CarriageTitle.FoodDrink
        case Shopping: return CarriageTitle.Shopping
        case LifeStyle: return CarriageTitle.LifeStyle
        case Tickets: return CarriageTitle.Tickets
        case Search: return CarriageTitle.Search
        case Info: return CarriageTitle.Info
        case Win: return CarriageTitle.Win
        case Maps: return CarriageTitle.Maps
        case WhatsOn: return CarriageTitle.WhatsOn
        }
    }
    
    func getCarriageImageName() -> CarriageImageName {
        switch self {
            case Rides: return CarriageImageName.Rides
            case Showbags: return CarriageImageName.Showbags
            case Plan: return CarriageImageName.Plan
            case FoodDrink: return CarriageImageName.FoodDrink
            case Shopping: return CarriageImageName.Shopping
            case LifeStyle: return CarriageImageName.LifeStyle
            case Tickets: return CarriageImageName.Tickets
            case Search: return CarriageImageName.Search
            case Info: return CarriageImageName.Info
            case Win: return CarriageImageName.Win
            case Maps: return CarriageImageName.Maps
            case WhatsOn: return CarriageImageName.WhatsOn
        }
    }
}

enum CarriageTitle : String {
    case Rides = "Rides"
    case Showbags = "Showbags"
    case Plan = "Plan"
    case FoodDrink = "Food & Drink"
    case Shopping = "Shopping"
    case LifeStyle = "LifeStyle"
    case Tickets = "Tickets"
    case Search = "Search"
    case Info = "Info"
    case Win = "Win"
    case Maps = "Maps"
    case WhatsOn = "What's On"
}

enum CarriageImageName : String {
    case Rides = "Rides"
    case Showbags = "Showbags"
    case Plan = "Plan"
    case FoodDrink = "FoodDrink"
    case Shopping = "Shopping"
    case LifeStyle = "Shows"
    case Tickets = "Tickets"
    case Search = "Search"
    case Info = "About"
    case Win = "Win"
    case Maps = "Maps"
    case WhatsOn = "Program"
}

class Carriage {
    let type: CarriageType!
    let carriageImageView: UIImageView!
    let carriageTitle: CarriageTitle!
    
    init(type: CarriageType) {
        self.type = type
        
        let carriageImage = UIImage(named:type.getCarriageImageName().rawValue)
        carriageImageView = UIImageView(image: carriageImage)
        
        carriageTitle = type.getCarriageTitle()
        
    }
}