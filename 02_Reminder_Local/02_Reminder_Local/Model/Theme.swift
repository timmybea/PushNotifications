//
//  Theme.swift
//  02_Reminder_Local
//
//  Created by Tim Beals on 2017-11-18.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

struct Theme {
    
    enum images {
        case dateIcon
        case calendarIcon
        case locationIcon
        
        var image: UIImage {
            switch self {
            case .dateIcon: return UIImage(named: "dateIcon") ?? UIImage()
            case .calendarIcon: return UIImage(named: "calendarIcon") ?? UIImage()
            case .locationIcon: return UIImage(named: "locationIcon") ?? UIImage()
        }
    }
    
    
    
}

