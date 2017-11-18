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
    }

    @IBAction func timeTapped(sender: UIButton) {
    
        print("TIME")
        UNService.shared.timerRequest(with: 5.0)
    }

    @IBAction func locationTapped(sender: UIButton) {
        
        print("LOCATION")
    }
    
}

