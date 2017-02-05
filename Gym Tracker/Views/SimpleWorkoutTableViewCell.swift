//
//  SimpleWorkoutTableViewCell.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 15/01/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import Foundation
import UIKit

class SimpleWorkoutTableViewCell: UITableViewCell {
    
    func setup(for indexPath: IndexPath) {
        let workout = AppManager.workouts[indexPath.section].2[indexPath.row]
        
        //self.nameLabel.text = AppManager.workouts[indexPath.section].0
        //self.resultLabel.text = workout.2[indexPath.]
    }
}
