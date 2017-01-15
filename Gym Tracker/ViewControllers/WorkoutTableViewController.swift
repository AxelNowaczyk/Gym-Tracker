//
//  WorkoutTableViewController.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 19/12/16.
//  Copyright © 2016 Axel Nowaczyk. All rights reserved.
//

import UIKit

class WorkoutTableViewController: UITableViewController {
    
    private enum Cell: String {
        case complex = "WorkoutTableViewCell"
        case simple = "SimpleWorkoutTableViewCell"
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppManager.workouts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellType: Cell = AppManager.usersToDisplay.count > 1 ? .complex : .simple
        let cell = tableView.dequeueReusableCell(withIdentifier: cellType.rawValue, for: indexPath)

        switch cellType {
        case .complex:
            setupTableViewCell(with: cell as! WorkoutTableViewCell, for: indexPath)
        case .simple:
            setupTableViewCell(with: cell as! SimpleWorkoutTableViewCell, for: indexPath)
        }

        return cell
    }

    private func setupTableViewCell(with cell: WorkoutTableViewCell, for indexPath: IndexPath) {
        cell.nameLabel.text = AppManager.workouts[indexPath.row].0
        cell.userLabel.text = AppManager.workouts[indexPath.row].1
        cell.resultLabel.text = AppManager.workouts[indexPath.row].2
    }

    private func setupTableViewCell(with cell: SimpleWorkoutTableViewCell, for indexPath: IndexPath) {
        cell.nameLabel.text = AppManager.workouts[indexPath.row].0
        cell.resultLabel.text = AppManager.workouts[indexPath.row].2
    }

}
