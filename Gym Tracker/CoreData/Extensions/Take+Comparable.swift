//
//  Take+Comparable.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 27/02/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import Foundation

extension Take: Comparable {
    
    public static func <(lhs: Take, rhs: Take) -> Bool {
        if lhs.weight == rhs.weight {
            return lhs.repsNumber < rhs.repsNumber
        } else {
            return lhs.weight < rhs.weight
        }
    }
    
}
