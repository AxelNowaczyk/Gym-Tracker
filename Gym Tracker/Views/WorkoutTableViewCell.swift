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

    func setup(reps: Int, weight: Double) {
        self.weightLabel.text = "\(weight)"
        self.repLabel.text = "\(reps)"
        
    }
}
