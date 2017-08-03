//
//  String+localizable.swift
//  Gym Tracker
//
//  Created by Nowaczyk Axel on 03/08/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
