//
//  Double+Round.swift
//  Gym Tracker
//
//  Created by Nowaczyk Axel on 19/10/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import Foundation

extension Double {
    var roundSecondPlace: Double {
        return (self*100).rounded()/100
    }
}
