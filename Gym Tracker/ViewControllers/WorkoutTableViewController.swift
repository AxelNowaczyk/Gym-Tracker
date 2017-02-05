//
//  WorkoutTableViewController.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 19/12/16.
//  Copyright © 2016 Axel Nowaczyk. All rights reserved.
//

import UIKit

class WorkoutTableViewController: UITableViewController {
    
    private enum CellType: String {
        case complex = "WorkoutTableViewCell"
        case simple = "SimpleWorkoutTableViewCell"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return AppManager.workouts.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppManager.workouts[section].2.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellType: CellType = .complex //AppManager.usersToDisplay.count > 1 ? .complex : .simple
        let cell = tableView.dequeueReusableCell(withIdentifier: cellType.rawValue, for: indexPath)

        //switch cellType {
        //case .complex:
            (cell as! WorkoutTableViewCell).setup(for: indexPath)
        //case .simple:
        //    (cell as! SimpleWorkoutTableViewCell).setup(for: indexPath)
        //}

        return cell
    }
    
   // override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
    //}
    
    private func showAddWorkoutViewController() {
        
        if let addWorkoutVC = UIStoryboard.init(name: "AddWorkout", bundle: nil).instantiateInitialViewController() {

            let newVCSize = CGRect(x: 30,
                                   y: 20 + addWorkoutVC.view.frame.height,
                                   width: addWorkoutVC.view.frame.width - 60,
                                   height: addWorkoutVC.view.frame.height - 40)
            
            addWorkoutVC.view.frame = newVCSize
            
            let blur = UIVisualEffectView(effect: UIBlurEffect(style: .light))
            blur.frame = UIScreen.main.bounds
            self.tabBarController?.view.addSubview(blur)
            
            self.tabBarController?.addChildViewController(addWorkoutVC)
            self.tabBarController?.view.addSubview(addWorkoutVC.view)
            
            UIView.animate(withDuration: 0.25) {
                addWorkoutVC.view.frame.origin.y = 20
            }
        }
        
    }
    
}
