//
//  AlertService.swift
//  03_iCloud_Notifications
//
//  Created by Tim Beals on 2017-11-27.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class AlertService {

    private init() { }

    static func composeNote(in vc: UIViewController, completion: @escaping (Note) -> Void) {

        let alert = UIAlertController(title: "New Note",
                                      message: "What's on your mind?",
                                      preferredStyle: .alert)
        alert.addTextField { (textfield) in
            textfield.placeholder = "Message"
        }
        let post = UIAlertAction(title: "POST", style: .default) { (_) in
            guard let title = alert.textFields?.first?.text else { return }
            let note = Note(title: title)
            completion(note)
        }
        alert.addAction(post)
        vc.present(alert, animated: true)
    }
}

