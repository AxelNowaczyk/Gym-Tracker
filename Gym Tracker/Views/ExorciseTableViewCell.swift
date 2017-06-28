//
//  exerciseTableViewCell.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 03/02/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "\(ExerciseTableViewCell.self)"

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var exerciseImageView: UIImageView!

    func setup(_ name: String) {
        nameLabel.text = name
        exerciseImageView.image = PictureProvider.retrievePictureForexercise(named: name) ?? #imageLiteral(resourceName: "exerciseIcon_default")
    }
    
}
