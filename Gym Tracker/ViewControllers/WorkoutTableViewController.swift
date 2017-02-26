//
//  WorkoutTableViewController.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 19/12/16.
//  Copyright © 2016 Axel Nowaczyk. All rights reserved.
//

import UIKit

class WorkoutTableViewController: UITableViewController {
    
    fileprivate let userProvider = UserProvider()
    fileprivate let takeProvider = TakeProvider()
    fileprivate let sessionProvider = SessionProvider()
    
    var data: [User:[Take]] = [:]
    
    private enum CellType: String {
        case complex = "WorkoutTableViewCell"
        case simple = "SimpleWorkoutTableViewCell"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadData()
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = Array(data.keys)[section]
        return data[key]?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellType: CellType = .complex //AppManager.usersToDisplay.count > 1 ? .complex : .simple
        let cell = tableView.dequeueReusableCell(withIdentifier: cellType.rawValue, for: indexPath)

        let key = Array(data.keys)[indexPath.section]
        if let workout = data[key]?[indexPath.row] {
        
        
        //switch cellType {
        //case .complex:
            (cell as! WorkoutTableViewCell).setup(reps: Int(workout.repsNumber), weight: workout.weight)
        //case .simple:
        //    (cell as! SimpleWorkoutTableViewCell).setup(for: indexPath)
        //}
        }
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
    
    fileprivate func reloadData() {
        data = [:]
        
        let users = userProvider.getAllUsers()
        for user in users {
            guard let session = sessionProvider.getLastSession(user: user),
                    let takesSet = session.including,
                    let takes = Array(takesSet) as? [Take]  else {
                continue
            }
            
            data[user] = takes
        }
        
        
    }
    
}







