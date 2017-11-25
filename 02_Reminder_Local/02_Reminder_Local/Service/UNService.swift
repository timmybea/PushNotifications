//
//  UNService.swift
//  02_Reminder_Local
//
//  Created by Tim Beals on 2017-11-18.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit
import UserNotifications

class UNService: NSObject {
    
    private override init() { }
    static let shared = UNService()
    let unCenter = UNUserNotificationCenter.current()
    
    func requestPermission() {
        
        let options: UNAuthorizationOptions = [.badge, .alert, .sound, .carPlay]
        unCenter.requestAuthorization(options: options) { (granted, error) in
            print(error?.localizedDescription ?? "No UN Authorization error")
            guard granted else {
                print("Permission not granted.")
                return
            }
            self.configure()
        }
    }
    
    private func configure() {
        unCenter.delegate = self
    }
    
    //MARK: REQUEST TYPES
    func timerRequest(with interval: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = "TIMER COMPLETED"
        content.body = "Your timer has ended. Yay."
        content.sound = .default()
        content.badge = 1
        
        if let attachment = getAttachment(for: .timer) {
            content.attachments = [attachment]
        }
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
        let request = UNNotificationRequest(identifier: "userNotification.timer", content: content, trigger: trigger)
        
        unCenter.add(request) { (error) in
            //Do nothing
        }
    }
    
    func dateRequest(with components: DateComponents) {
        let content = UNMutableNotificationContent()
        content.title = "TODAY IS THE DAY"
        content.body = "Is there something important that you should do before the sun sets?"
        content.sound = .default()
        content.badge = 1
        
        if let attachment = getAttachment(for: .date) {
            content.attachments = [attachment]
        }
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: "userNotification.date", content: content, trigger: trigger)
        unCenter.add(request) //This is the concise way without completion handler.
    }
    
    func locationRequest() {
        let content = UNMutableNotificationContent()
        content.title = "HERE YOU ARE!"
        content.body = "You have reentered the location that you set."
        content.sound = .default()
        content.badge = 1
        
        if let attachment = getAttachment(for: .location) {
            content.attachments = [attachment]
        }
        
        //NOTE THAT AT THE TIME OF THIS TUTORIAN 'UNLocationNotificationTrigger' IS UNRELIABLE, WHICH IS WHY WE IMPLEMENTED THE CL SERVICE CLASS.
        let request = UNNotificationRequest(identifier: "userNotification.location", content: content, trigger: nil)
        unCenter.add(request)
    }
    
    func getAttachment(for id: NotificationAttachmentID) -> UNNotificationAttachment?{
        /* Put the alert images in the bundle as opposed to the assets folder, otherwise you will have to
        use file paths to access the image data */
        
        let imageName: String = id.imageName
        guard let url = Bundle.main.url(forResource: imageName, withExtension: "png") else { return nil }
//        do {
//            let attachment = try UNNotificationAttachment(identifier: id.rawValue, url: url, options: nil)
//            return attachment
//        } catch {
//            return nil
//        }
        return try? UNNotificationAttachment(identifier: id.rawValue, url: url, options: nil)
    }
}

extension UNService: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("UN will present notification")
        
        let options: UNNotificationPresentationOptions = [.alert, .sound]
        completionHandler(options)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("UN did receive response")
        
        completionHandler()
    }
  
}
