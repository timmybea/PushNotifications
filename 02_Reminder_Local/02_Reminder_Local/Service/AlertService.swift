//
//  AlertService.swift
//  02_Reminder_Local
//
//  Created by Tim Beals on 2017-11-18.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class AlertService: NSObject {
    
    private override init() { }
    
    static func actionSheet(in vc: UIViewController, title: String, completion: @escaping() -> Void) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: title, style: .default) { (_) in
            completion()
        }
        alert.addAction(action)
        vc.present(alert, animated: true)
    }
}
