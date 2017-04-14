//
//  HistoryTableViewController.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 19/12/16.
//  Copyright © 2016 Axel Nowaczyk. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {

    var exorciseNames: [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    fileprivate enum SegueName: String {
        case history = "HistorySegue"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        exorciseNames = ExorciseProvider().exorciseNames
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard   let id = segue.identifier,
                let segueName = SegueName(rawValue: id) else {
            print("unknown segue")
            return
        }
        
        switch segueName {
        case .history:
            self.setupForHistorySegue(destination: segue.destination)
        }
    }

    private func setupForHistorySegue(destination viewController: UIViewController) {
        if  let dvc = viewController as? MainHistoryViewController,
            let selectedRow = tableView.indexPathForSelectedRow?.row {

            dvc.exorciseName = exorciseNames[selectedRow]
            (tabBarController as? MainTabBarController)?.selectedExorciseName = dvc.exorciseName
        }
    }

}

// MARK: - Table view data source

extension HistoryTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exorciseNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.reuseIdentifier, for: indexPath)
        (cell as? HistoryTableViewCell)?.setup(exorciseNames[indexPath.row])
        return cell
    }
}
