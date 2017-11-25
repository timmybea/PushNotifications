//
//  NotificationAttachmentID.swift
//  02_Reminder_Local
//
//  Created by Tim Beals on 2017-11-25.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import Foundation

enum NotificationAttachmentID: String {
    case timer = "userNotification.attachment.timer"
    case date = "userNotification.attachment.date"
    case location = "userNotification.attachment.location"
    
    var imageName: String {
        switch self {
        case .date: return "DateAlert"
        case .location: return "LocationAlert"
        case .timer: return "TimeAlert"
        }
    }
}
