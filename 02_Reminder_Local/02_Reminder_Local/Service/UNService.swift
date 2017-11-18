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
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
        let request = UNNotificationRequest(identifier: "userNotification.timer", content: content, trigger: trigger)
        
        unCenter.add(request) { (error) in
            //Do nothing
        }
    }
    
    func dateRequest(with components: DateComponents) {
        
    }
    
    func locationRequest() {
        
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
