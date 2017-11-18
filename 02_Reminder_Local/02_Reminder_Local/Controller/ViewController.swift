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
    }
    
}

