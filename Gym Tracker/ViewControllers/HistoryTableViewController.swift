//
//  HistoryTableViewController.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 19/12/16.
//  Copyright © 2016 Axel Nowaczyk. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {

    var exerciseNames: [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    fileprivate enum SegueName: String {
        case history = "HistorySegue"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        exerciseNames = ExerciseProvider.exerciseNames
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard   let id = segue.identifier,
                let segueName = SegueName(rawValue: id) else {
            print("unknown segue")
            return
        }
        
        setup(viewController: segue.destination, forSegue: segueName)
    }

    private func setup(viewController: UIViewController, forSegue segue: SegueName) {
        switch segue {
        case .history:
            guard let dvc = viewController as? MainHistoryViewController,
                let selectedRow = tableView.indexPathForSelectedRow?.row else {
                    return
            }
            dvc.exerciseName = exerciseNames[selectedRow]
            (tabBarController as? MainTabBarController)?.selectedExerciseName = dvc.exerciseName
        }
    }
}

// MARK: - Table view data source

extension HistoryTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.reuseIdentifier, for: indexPath)
        (cell as? HistoryTableViewCell)?.setup(exerciseNames[indexPath.row])
        return cell
    }
}
