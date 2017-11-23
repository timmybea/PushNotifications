//
//  ViewController.swift
//  02_Reminder_Local
//
//  Created by Tim Beals on 2017-11-18.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UNService.shared.requestPermission()
        CLService.shared.requestPermission()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didEnterRegion),
                                               name: NSNotification.Name("internalNotification.enteredRegion"),
                                               object: nil)
        
    }

    @IBAction func dateTapped(sender: UIButton) {
        print("DATE")
        AlertService.actionSheet(in: self, title: "Every minute") {
            var components = DateComponents()
            components.second = 0
            UNService.shared.dateRequest(with: components)
        }
    }

    @IBAction func timeTapped(sender: UIButton) {
        print("TIME")
        AlertService.actionSheet(in: self, title: "5 Seconds") {
            UNService.shared.timerRequest(with: 5.0)
        }
    }

    @IBAction func locationTapped(sender: UIButton) {
        print("LOCATION")
        AlertService.actionSheet(in: self, title: "Where in the world!?") {
            CLService.shared.updateLocation()
        }
        
    }
    
    @objc
    func didEnterRegion() {
        UNService.shared.locationRequest()
    }
    
}

