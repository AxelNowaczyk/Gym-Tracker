//
//  HistoryTableViewCell.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 16/01/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var exorciseImageView: UIImageView!
    
    func setup(_ name: String) {
        nameLabel.text = name
        exorciseImageView.image = PictureProvider().retrievePictureForExorcise(named: name) ?? #imageLiteral(resourceName: "exorciseIcon_default")
    }
    
}
