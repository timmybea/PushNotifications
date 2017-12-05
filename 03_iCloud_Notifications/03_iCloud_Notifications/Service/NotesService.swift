//
//  NotesService.swift
//  03_iCloud_Notifications
//
//  Created by Tim Beals on 2017-12-04.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import Foundation

class NotesService {
    //Notes service is designed to interface with the CKService. It takes the records returned from the query and turns them into notes using a custom initializer.
    
    private init() { }
    
    static func getNotes(completion: @escaping([Note]) -> Void) {
        CKService.shared.query(recordType: Note.recordType) { (records) in
            var notes = [Note]()
            for record in records {
                if let note = Note.init(record: record) {
                    notes.append(note)
                }
            }
            completion(notes)
        }
    }
    
}
