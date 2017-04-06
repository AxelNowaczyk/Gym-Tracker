//
//  WorkoutTableViewController.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 19/12/16.
//  Copyright © 2016 Axel Nowaczyk. All rights reserved.
//

import UIKit

class WorkoutTableViewController: UITableViewController {
    
    fileprivate let exorciseProvider            = ExorciseProvider()
    fileprivate var exorciseNames: [String]     = [] {
        didSet {
            tableView.reloadData()
        }
    }

    fileprivate enum CellIdentifierType: String {
        case exorcise = "ExorciseTableViewCell"
    }
    
    fileprivate enum SegueType: String {
        case toAddWorkout = "RecentWorkoutsToAddWorkoutViewControllerSegue"
    }

    @IBAction func addBarButtonWasPressed(_ sender: UIBarButtonItem) {

        let alert = AlertUtil.createAlertWithTextField( title: "Write name for the new exorcise: ",
                                                        message: "",
                                                        textFieldPlaceholder: "Exorcise Name", withText: nil) { textFieldText in
                                                            
                                                            if self.exorciseNames.first(where: { $0 == textFieldText }) == nil {
                                                                self.exorciseNames.append(textFieldText)
                                                            }

        }
        present(alert, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exorciseNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifierType.exorcise.rawValue, for: indexPath)
        (cell as! ExorciseTableViewCell).setup(exorciseNames[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: SegueType.toAddWorkout.rawValue, sender: nil)
    }

    fileprivate func reloadData() {
        exorciseNames = exorciseProvider.exorciseNames
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let segueType = SegueType(rawValue: segue.identifier ?? "") else {
            return
        }
        
        switch segueType {
        case .toAddWorkout:
            
            guard let selectedRow = tableView.indexPathForSelectedRow?.row else {
                return
            }
            let addWorkoutViewController = segue.destination as! AddWorkoutViewController
            addWorkoutViewController.exorciseName = exorciseNames[selectedRow]
            (tabBarController as? MainTabBarController)?.selectedExorciseName = addWorkoutViewController.exorciseName
        }
        
    }
    
}

extension WorkoutTableViewController {
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { action, index in
            let alert = AlertUtil.createAlertWithTextField( title: "Write new name for the exorcise: ",
                                                            message: "",
                                                            textFieldPlaceholder: "Exorcise Name", withText: self.exorciseNames[indexPath.row]) { textFieldText in
                                                                
                                                                self.exorciseProvider.changeNameForExorcices(named: self.exorciseNames[indexPath.row], with: textFieldText)
                                                                tableView.reloadData()
            }
            self.present(alert, animated: true, completion: nil)
        }
        editAction.backgroundColor = .blue
        
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            self.exorciseProvider.removeExorcices(named: self.exorciseNames[indexPath.row])
            tableView.reloadData()
        }
        deleteAction.backgroundColor = .red
        
        return [deleteAction,editAction]
    }

}






