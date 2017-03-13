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
 
    let debug = true

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        performInitialSetup {
            [unowned self] in
            
            self.performSegue(withIdentifier: "Show tabbarController", sender: self)
        }
        
    }
    
    func performInitialSetup(completionHandler: () -> Void) {
        
        if debug {
            performInitialSetupForDebug {
                completionHandler()
            }
        } else {
            performInitialSetupForRelease {
                completionHandler()
            }
        }
    }

    func performInitialSetupForRelease(completionHandler: () -> Void) {
        
        if UserProvider().users.count == 0 {
            
            let userProvider = UserProvider()
            _ = userProvider.storeUser(named: "Axel")
            _ = userProvider.storeUser(named: "Maciek")
            
        }
        
        completionHandler()
    }
    
    func performInitialSetupForDebug(completionHandler: () -> Void) {
        
        if UserProvider().users.count == 0 {
            setupWorkouts(userName: "Axel")
            setupWorkouts(userName: "Axel2", offset: 1)
            setupWorkouts(userName: "Axel3", offset: 2)
            
        }
        
        completionHandler()
    }
    
    private func setupWorkouts(userName: String, offset: Int = 0) {
        
        let user        = UserProvider().storeUser(named: userName)
        let session     = SessionProvider().storeSession(for: user)
        user.addToPerformed(session)
        
        let exorciseProvider = ExorciseProvider()
        let takeProvider = TakeProvider()
        let squats = exorciseProvider.storeExorcise(named: "Squats", in: session)
        _ = takeProvider.storeTake(repsNumber: 10+offset, weight: 20, for: squats)
        _ = takeProvider.storeTake(repsNumber: 10+offset, weight: 35, for: squats)
        _ = takeProvider.storeTake(repsNumber: 10+offset, weight: 50, for: squats)
        let pushups = exorciseProvider.storeExorcise(named: "Pushups", in: session)
        _ = takeProvider.storeTake(repsNumber: 20+offset, weight: 20, for: pushups)
        _ = takeProvider.storeTake(repsNumber: 20+offset, weight: 35, for: pushups)
        _ = takeProvider.storeTake(repsNumber: 20+offset, weight: 50, for: pushups)
        let pullups = exorciseProvider.storeExorcise(named: "Pullups", in: session)
        _ = takeProvider.storeTake(repsNumber: 30+offset, weight: 20, for: pullups)
        _ = takeProvider.storeTake(repsNumber: 30+offset, weight: 35, for: pullups)
        _ = takeProvider.storeTake(repsNumber: 30+offset, weight: 50, for: pullups)
    }
    
    
}
