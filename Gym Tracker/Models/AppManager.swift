//
//  AppManager.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 15/01/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import Foundation

public class AppManager: NSObject {
    
    static let shared = AppManager()
    
    var _users = [User]()
    static var users: [User] {
        get {
            return self.shared._users
        }
        set {
            self.shared._users = newValue
        }
    }
    
    struct Workout {
        var reps: Int = 0
        var weight: Int = 0

    }
    
    private var _workouts = [("Squats","Axel",[Workout(reps: 12, weight: 20),Workout(reps: 8, weight: 35),Workout(reps: 3, weight: 50)]),("Pushups","Axel",[Workout(reps: 12, weight: 20),Workout(reps: 8, weight: 35),Workout(reps: 3, weight: 50)]),("Pullups","Axel",[Workout(reps: 12, weight: 20),Workout(reps: 8, weight: 35),Workout(reps: 3, weight: 50)])]
    static var workouts: [(String, String, [Workout])] {
        return self.shared._workouts
    }
    
    public static func performInitialSetup(completionHandler: (Void) -> Void) {
        
        let userProvider = UserProvider()
        
        users = userProvider.getAllUsers()
        if users.count == 0 {
            userProvider.storeUser(with: "Axel", shouldBeShown: true)
        }
        
        completionHandler()
        
    }

}
