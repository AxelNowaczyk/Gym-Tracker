//
//  SettingsTableViewCell.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 15/01/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import UIKit

protocol SettingsTableViewCellDelegate {
    func cellDidChangeStatus(cell: SettingsTableViewCell, for userName: String, to status: Bool)
}


class SettingsTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var visibilitySwitch: UISwitch!
    
    @IBAction func visibilitySwitchValueChanged(_ sender: UISwitch) {
        delegate?.cellDidChangeStatus(cell: self, for: nameLabel.text!, to: visibilitySwitch.isOn)
    }
    
    var delegate: SettingsTableViewCellDelegate?
    
    func setup(for user: String?, hidden: Bool) {
        nameLabel.text = user ?? "No name"
        visibilitySwitch.isOn = !hidden
    }
}
