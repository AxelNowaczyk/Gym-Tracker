//
//  DateFormatterUtil.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 11/03/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import Foundation

class DateFormatterUtil: DateFormatter {
    
    override init() {
        super.init()
        
        self.dateStyle = .medium
        self.timeStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
