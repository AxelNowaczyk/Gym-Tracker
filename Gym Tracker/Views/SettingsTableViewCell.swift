//
//  SettingsTableViewCell.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 13/03/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var visibilitySwitch: UISwitch!
    
    @IBAction func visibilitySwitchValueChanged(_ sender: UISwitch) {
        switchFunction?(visibilitySwitch.isOn)
    }
    
    fileprivate var switchFunction: SwitchFunction?
    typealias SwitchFunction = (Bool) -> Void
    func setup(for user: String, hidden: Bool, switchFunction: @escaping SwitchFunction) {
        nameLabel.text = user
        visibilitySwitch.isOn = !hidden
        self.switchFunction = switchFunction
    }
}
