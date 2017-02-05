//
//  WorkoutTableViewCell.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 19/12/16.
//  Copyright © 2016 Axel Nowaczyk. All rights reserved.
//

import UIKit

class WorkoutTableViewCell: UITableViewCell {

    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var repLabel: UILabel!

    func setup(for indexPath: IndexPath) {
        let workout = AppManager.workouts[indexPath.section].2[indexPath.row]
        
        self.weightLabel.text = "\(workout.weight)"
        self.repLabel.text = "\(workout.reps)"
        
    }
}
