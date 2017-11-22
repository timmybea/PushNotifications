//
//  CLService.swift
//  02_Reminder_Local
//
//  Created by Tim Beals on 2017-11-22.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit
import CoreLocation

class CLService: NSObject {

    private override init() { }
    static let shared = CLService()
    
    let locMan = CLLocationManager()
    
    private func getAuthorization() {
        locMan.requestAlwaysAuthorization()
        locMan.desiredAccuracy = kCLLocationAccuracyBest
        locMan.delegate = self        
    }
    
}

extension CLService: CLLocationManagerDelegate {
    
    
    
}
