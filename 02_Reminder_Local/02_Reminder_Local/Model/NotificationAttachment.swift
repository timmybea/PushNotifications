//
//  NotificationAttachmentID.swift
//  02_Reminder_Local
//
//  Created by Tim Beals on 2017-11-25.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import Foundation

enum NotificationAttachment {
    
    case timer
    case date
    case location
    
    var imageName: String {
        switch self {
        case .date: return "DateAlert"
        case .location: return "LocationAlert"
        case .timer: return "TimeAlert"
        }
    }
    
    var id: String {
        switch self {
        case .date: return "userNotification.attachment.date"
        case .location: return "userNotification.attachment.location"
        case .timer: return "userNotification.attachment.timer"
        }
    }
}
