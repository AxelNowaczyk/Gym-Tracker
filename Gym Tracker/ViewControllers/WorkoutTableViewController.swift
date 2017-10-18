//
//  WorkoutTableViewController.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 19/12/16.
//  Copyright © 2016 Axel Nowaczyk. All rights reserved.
//

import UIKit

class WorkoutTableViewController: UITableViewController {
    
    @IBAction func addBarButtonWasPressed(_ sender: UIBarButtonItem) {

        let alert = AlertUtil.createAlertWithTextField( title: "\("Alert_Add_exorcise_Title".localized): ",
                                                        message: "",
                                                        textFieldPlaceholder: "Alert_Add_exorcise_Placeholder".localized, withText: nil) { textFieldText in
                                                            
                                                            if self.exerciseNames.first(where: { $0 == textFieldText }) == nil {
                                                                self.exerciseNames.append(textFieldText)
                                                            }

        }
        present(alert, animated: true, completion: nil)
    }
    
    fileprivate var exerciseNames: [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    fileprivate enum SegueType: String {
        case toAddWorkout = "RecentWorkoutsToAddWorkoutViewControllerSegue"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        reloadData()
    }

    fileprivate func reloadData() {
        exerciseNames = ExerciseProvider.exerciseNames
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
            addWorkoutViewController.exerciseName = exerciseNames[selectedRow]
            (tabBarController as? MainTabBarController)?.selectedExerciseName = addWorkoutViewController.exerciseName
        }
        
    }
    
}

extension WorkoutTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ExerciseTableViewCell.reuseIdentifier, for: indexPath) as! ExerciseTableViewCell
        cell.setup(exerciseNames[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: SegueType.toAddWorkout.rawValue, sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .normal, title: "Table_View_Edit".localized) { action, index in
            let alert = AlertUtil.createAlertWithTextField( title: "\("Alert_Edit_exorcise_Title".localized): ",
                                                            message: "",
                                                            textFieldPlaceholder: "Alert_Edit_exorcise_Placeholder".localized, withText: self.exerciseNames[indexPath.row]) { textFieldText in
                                                                
                                                                guard nil == (self.exerciseNames.first { $0 == textFieldText }) else {
                                                                    return
                                                                }
                                                                
                                                                ExerciseProvider.changeNameForExorcices(named: self.exerciseNames[indexPath.row], with: textFieldText)
                                                                PictureProvider.changeName(oldName: self.exerciseNames[indexPath.row], newName: textFieldText)
                                                                CoreDataStack.shared.save()
                                                                self.reloadData()
            }
            self.present(alert, animated: true, completion: nil)
        }
        editAction.backgroundColor = .blue
        
        let deleteAction = UITableViewRowAction(style: .normal, title: "Table_View_Delete".localized) { action, index in
            ExerciseProvider.removeExorcices(named: self.exerciseNames[indexPath.row])
            PictureProvider.deletePictureForexercise(named: self.exerciseNames[indexPath.row])
            CoreDataStack.shared.save()
            self.reloadData()
        }
        deleteAction.backgroundColor = .red
        
        return [deleteAction,editAction]
    }

}
