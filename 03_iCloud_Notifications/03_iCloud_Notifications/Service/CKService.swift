//
//  CKService.swift
//  03_iCloud_Notifications
//
//  Created by Tim Beals on 2017-11-28.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import Foundation
import CloudKit

class CKService {
    
    private init() { }

    static let shared = CKService()
    
    let privateDatabase = CKContainer.default().privateCloudDatabase
    
    func save(record: CKRecord) {
        privateDatabase.save(record) { (record, error) in
            print(error ?? "No ck save error")
            print(record ?? "No ck record object to save")
        }
    }
    
    func query(recordType: String, completion: @escaping ([CKRecord]) -> Void) {
        let query = CKQuery(recordType: recordType, predicate: NSPredicate(value: true))
        privateDatabase.perform(query, inZoneWith: nil) { (records, error) in
            print(error?.localizedDescription ?? "no CKQuery error")
            guard let records = records else { return }
            DispatchQueue.main.async {
                completion(records)
            }
        }
    }
    
}

