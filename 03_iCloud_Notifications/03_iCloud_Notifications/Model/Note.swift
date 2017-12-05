//
//  Note.swift
//  03_iCloud_Notifications
//
//  Created by Tim Beals on 2017-11-27.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import Foundation
import CloudKit

struct Note {
    
    static let recordType = "Note"
    
    init(title: String) {
        self.title = title
    }
    
    init?(record: CKRecord) {
        guard let title = record.value(forKey: "title") as? String else { return nil }
        self.title = title
    }
    
    var title: String = ""
    
    func noteRecord() -> CKRecord {
        let record = CKRecord(recordType: Note.recordType)
        record.setValue(title, forKey: "title")
        return record
    }
}
