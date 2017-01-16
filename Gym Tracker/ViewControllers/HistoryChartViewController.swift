//
//  HistoryChartViewController.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 20/12/16.
//  Copyright © 2016 Axel Nowaczyk. All rights reserved.
//

import Foundation
import UIKit

class HistoryChartViewController: UIViewController {
    var exorcise = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = exorcise
    }
}
