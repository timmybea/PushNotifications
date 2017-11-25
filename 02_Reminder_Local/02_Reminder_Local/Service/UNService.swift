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
        setupActionsAndCategories()
    }
    
    //MARK: REQUEST TYPES
    func timerRequest(with interval: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = "TIMER COMPLETED"
        content.body = "Your timer has ended. Yay."
        content.sound = .default()
        content.badge = 1
        content.categoryIdentifier = NotificationCategory.timer.id
        
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
        content.categoryIdentifier = NotificationCategory.date.id
        
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
        content.categoryIdentifier = NotificationCategory.location.id
        
        if let attachment = getAttachment(for: .location) {
            content.attachments = [attachment]
        }
        
        //NOTE THAT AT THE TIME OF THIS TUTORIAN 'UNLocationNotificationTrigger' IS UNRELIABLE, WHICH IS WHY WE IMPLEMENTED THE CL SERVICE CLASS.
        let request = UNNotificationRequest(identifier: "userNotification.location", content: content, trigger: nil)
        unCenter.add(request)
    }
    
    func setupActionsAndCategories() {
        let timerAction = UNNotificationAction(identifier: NotificationAction.timer.id,
                                               title: "Run Timer Logic",
                                               options: [.authenticationRequired])
        
        let dateAction = UNNotificationAction(identifier: NotificationAction.date.id, title: "Run Date Logic", options: [.destructive])
        
        let locationAction = UNNotificationAction(identifier: NotificationAction.location.id, title: "Run location Logic", options: [.foreground])
        
        /* NotificationActionOptions:
         authenticationRequired - User must unlock their phone before logic will run in the background
         destructive - The button will be red. Logic will run in the background
         foreground - brings the app into the foreground before running the logic
         */
        
        let timerCategory = UNNotificationCategory(identifier: NotificationCategory.timer.id,
                                                   actions: [timerAction],
                                                   intentIdentifiers: [])
        
        let dateCategory = UNNotificationCategory(identifier: NotificationCategory.date.id,
                                                  actions: [dateAction],
                                                  intentIdentifiers: [])
        
        let locationCategory = UNNotificationCategory(identifier: NotificationCategory.location.id,
                                                      actions: [locationAction],
                                                      intentIdentifiers: [])
        unCenter.setNotificationCategories([timerCategory, dateCategory, locationCategory])
    }
    
    func getAttachment(for attachment: NotificationAttachment) -> UNNotificationAttachment?{
        /* Put the alert images in the bundle as opposed to the assets folder, otherwise you will have to
        use file paths to access the image data */
        let imageName: String = attachment.imageName
        guard let url = Bundle.main.url(forResource: imageName, withExtension: "png") else { return nil }
        return try? UNNotificationAttachment(identifier: attachment.id, url: url, options: nil)
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
        /* This will be triggered when you push the action button below the notification, and you can direct to logic for each type of action*/
        let action = response.actionIdentifier
        NotificationCenter.default.post(name: NSNotification.Name("internalNotification.handleAction"), object: action)
        
        completionHandler()
    }
  
}
