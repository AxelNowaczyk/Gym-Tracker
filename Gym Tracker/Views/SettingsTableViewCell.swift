//
//  SettingsTableViewCell.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 15/01/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var visibilitySwitch: UISwitch!

    func setup(for user: String?, hidden: Bool) {
        nameLabel.text = user ?? "No name"
        visibilitySwitch.isOn = hidden
    }
    
}
