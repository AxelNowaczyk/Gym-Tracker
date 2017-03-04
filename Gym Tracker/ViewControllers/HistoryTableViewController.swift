//
//  HistoryTableViewController.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 19/12/16.
//  Copyright © 2016 Axel Nowaczyk. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {

    private var selectedRow: Int?
    
    private struct CellIdentifiers {
        static let complex = "HistoryTableViewCell"
        static let simple = "SimpleHistoryTableViewCell"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0 //AppManager.workouts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.simple, for: indexPath)

//        switch cellType {
//        case .complex:
//            setupTableViewCell(with: cell as! HistoryTableViewCell, for: indexPath)
//        case .simple:
            setupTableViewCell(with: cell as! SimpleHistoryTableViewCell, for: indexPath)
//        }

        return cell
    }
 
    private func setupTableViewCell(with cell: HistoryTableViewCell, for indexPath: IndexPath) {
//        cell.nameLabel.text = AppManager.workouts[indexPath.row].0
//        cell.userLabel.text = AppManager.workouts[indexPath.row].1
    }
    
    private func setupTableViewCell(with cell: SimpleHistoryTableViewCell, for indexPath: IndexPath) {
//        cell.nameLabel.text = AppManager.workouts[indexPath.row].0
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
//            dvc.selectedExorcise = AppManager.workouts[selectedRow].0
        }
    }

}
