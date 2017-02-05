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
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        AppManager.performInitialSetup {
            
            [unowned self] in
            
            
            //let vc =
            //let mainTabBarControllerID = StoryboardViewControllerResource<UIKit.UITabBarController>(identifier: "MainTabBarControllerID")
            //let vc = UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: mainTabBarControllerID)
            
            //self.present(vc, animated: true, completion: nil)
            self.performSegue(withIdentifier: "Show tabbarController", sender: self)
        }
        
    }
    
    deinit {
        print("did deinit")
    }
    
}
