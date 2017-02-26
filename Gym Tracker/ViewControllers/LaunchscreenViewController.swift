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
 
    deinit {
        print("did deinit")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        performInitialSetup { 
            [unowned self] in
            
            self.performSegue(withIdentifier: "Show tabbarController", sender: self)
        }
        
    }
    
    func performInitialSetup(completionHandler: () -> Void) {
        
        if UserProvider().getAllUsers().count == 0 {
            setupWorkouts()
        }

        completionHandler()
    }

    private func setupWorkouts() {
        
        let user        = UserProvider().storeUser(named: "Axel")
        let session     = SessionProvider().storeSession()
        user.addToPerformed(session)
        
        let takeProvider = TakeProvider()
        let squats = ExorciseProvider().storeExorcise(named: "Squats")
        _ = takeProvider.storeTake(repsNumber: 12, weight: 20, exorcise: squats, for: session)
        _ = takeProvider.storeTake(repsNumber: 8, weight: 35, exorcise: squats, for: session)
        _ = takeProvider.storeTake(repsNumber: 3, weight: 50, exorcise: squats, for: session)
        let pushups = ExorciseProvider().storeExorcise(named: "Pushups")
        _ = takeProvider.storeTake(repsNumber: 12, weight: 20, exorcise: pushups, for: session)
        _ = takeProvider.storeTake(repsNumber: 8, weight: 35, exorcise: pushups, for: session)
        _ = takeProvider.storeTake(repsNumber: 3, weight: 50, exorcise: pushups, for: session)
        let pullups = ExorciseProvider().storeExorcise(named: "Pullups")
        _ = takeProvider.storeTake(repsNumber: 12, weight: 20, exorcise: pullups, for: session)
        _ = takeProvider.storeTake(repsNumber: 8, weight: 35, exorcise: pullups, for: session)
        _ = takeProvider.storeTake(repsNumber: 3, weight: 50, exorcise: pullups, for: session)
    }
    
    
}
