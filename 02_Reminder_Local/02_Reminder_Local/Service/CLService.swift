//
//  CLService.swift
//  02_Reminder_Local
//
//  Created by Tim Beals on 2017-11-22.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import Foundation
import CoreLocation

class CLService: NSObject {

    private override init() { }
    static let shared = CLService()
    
    let locMan = CLLocationManager()
    var shouldSetRegion = true
    
    func requestPermission() {
        locMan.requestAlwaysAuthorization()
        locMan.desiredAccuracy = kCLLocationAccuracyBest
        locMan.delegate = self        
    }
    
    func updateLocation() {
        locMan.startUpdatingLocation()
        shouldSetRegion = true
    }
    
}

extension CLService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Did update location")
        guard let currentLoc = locations.first, shouldSetRegion else { return }
        shouldSetRegion = false
        let region = CLCircularRegion(center: currentLoc.coordinate,
                                      radius: 20,
                                      identifier: "currLocation")
        manager.startMonitoring(for: region)
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Did enter region")
        NotificationCenter.default.post(name: NSNotification.Name("internalNotification.enteredRegion"),
                                        object: nil)
    }
    
}
