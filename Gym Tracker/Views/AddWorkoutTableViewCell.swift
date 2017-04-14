//
//  AddWorkoutTableViewCell.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 05/03/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import UIKit

class AddWorkoutTableViewCell: UITableViewCell {

    static let reuseIdentifier = "\(AddWorkoutTableViewCell.self)"
    
    @IBOutlet var weightBigLabel: UILabel!
    @IBOutlet var weightSmallLabel: UILabel!
    @IBOutlet var repsBigLabel: UILabel!
    @IBOutlet var repsSmallLabel: UILabel!

}
