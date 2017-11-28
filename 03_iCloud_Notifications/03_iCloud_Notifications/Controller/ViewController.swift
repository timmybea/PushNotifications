//
//  ViewController.swift
//  03_iCloud_Notifications
//
//  Created by Tim Beals on 2017-11-27.
//  Copyright © 2017 Tim Beals. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var notes = [Note]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func composedTapped(sender: UIBarButtonItem) {
        AlertService.composeNote(in: self) { (note) in
            self.insert(note: note)
        }
    }
    
    private func insert(note: Note) {
        self.notes.insert(note, at: 0)
        let indexPath = IndexPath(item: 0, section: 0)
        self.tableView.insertRows(at: [indexPath], with: .automatic)
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let note = notes[indexPath.row]
        cell.textLabel?.text = note.title
        return cell
    }
}

