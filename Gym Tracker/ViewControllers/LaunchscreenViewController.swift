//
//  LaunchscreenViewController.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 15/01/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import Foundation
import UIKit

class LaunchscreenViewController: UIViewController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppManager.performInitialSetup {

            [unowned self] in

            self.performSegue(withIdentifier: "Show tabbarController", sender: self)
        }
    }
    
}
