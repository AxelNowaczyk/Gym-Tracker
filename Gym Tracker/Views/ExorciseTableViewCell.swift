//
//  ExorciseTableViewCell.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 03/02/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import UIKit

class ExorciseTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "\(ExorciseTableViewCell.self)"

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var exorciseImageView: UIImageView!

    func setup(_ name: String) {
        nameLabel.text = name
        exorciseImageView.image = PictureProvider.retrievePictureForExorcise(named: name) ?? #imageLiteral(resourceName: "exorciseIcon_default")
    }
    
}
