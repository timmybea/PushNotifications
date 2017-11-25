//
//  NotificationAction.swift
//  02_Reminder_Local
//
//  Created by Tim Beals on 2017-11-25.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import Foundation

enum NotificationAction {
    
    case timer
    case location
    case date
    
    var id: String {
        switch self {
        case .timer: return "UserNotification.Action.timer"
        case .location: return "UserNotification.Action.location"
        case .date: return "UserNotification.Action.date"
        }
    }
}
