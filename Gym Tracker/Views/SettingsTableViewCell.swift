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


    func setup(for indexPath: IndexPath) {
        
        nameLabel.text = AppManager.users[indexPath.row].name
        visibilitySwitch.isOn = AppManager.users[indexPath.row].isShowing
        
    }
    
}
