//
//  NotificationCategory.swift
//  02_Reminder_Local
//
//  Created by Tim Beals on 2017-11-25.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import Foundation

enum NotificationCategory {
    
    case location
    case date
    case timer
    
    var id: String {
        switch self {
        case .location: return "userNotification.category.location"
        case .date: return "userNotification.category.date"
        case .timer: return "userNotification.category.timer"
        }
    }
}
