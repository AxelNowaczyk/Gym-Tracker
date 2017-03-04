//
//  WorkoutTableViewCell.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 19/12/16.
//  Copyright © 2016 Axel Nowaczyk. All rights reserved.
//

import UIKit

class WorkoutTableViewCell: UITableViewCell {

    @IBOutlet var exorciseNameLabel: UILabel!
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var repLabel: UILabel!

    func setup(exorciseName: String, reps: Int, weight: Double) {
        exorciseNameLabel.text = exorciseName
        weightLabel.text = "\(weight)"
        repLabel.text = "\(reps)"
        
    }
}
