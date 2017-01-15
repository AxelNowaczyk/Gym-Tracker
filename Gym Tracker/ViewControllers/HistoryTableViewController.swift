//
//  HistoryTableViewController.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 19/12/16.
//  Copyright © 2016 Axel Nowaczyk. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {

    private var data = ["11","21","31"]
    private var selectedRow: Int?

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath)

        if let workoutCell = cell as? HistoryTableViewCell {
            workoutCell.nameLabel.text = data[indexPath.row]
            workoutCell.userLabel.text = "Axel"
        }

        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedRow = indexPath.row
        
        self.performSegue(withIdentifier: "HistorySegue", sender: self)
        
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let id = segue.identifier else {
            print("no id")
            return
        }
        
        switch id {
        case "HistorySegue":
            self.setupForHistorySegue(destination: segue.destination)
        default: break
        }

    }
 
    private func setupForHistorySegue(destination viewController: UIViewController) {
        if  let dvc = viewController as? HistoryTabBarController,
            let selectedRow = self.selectedRow {
            dvc.selectedExorcise = self.data[selectedRow]
        }
    }

}
