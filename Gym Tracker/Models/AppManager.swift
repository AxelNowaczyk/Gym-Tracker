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
    
    var _users = [Users]()
    static var users: [Users] {
        get {
            return self.shared._users
        }
        set {
            self.shared._users = newValue
        }
    }
    
    static var usersToDisplay: [Users] {

        var usersToShow = [Users]()
        for user in users {
            if user.isShowing {
                usersToShow.append(user)
            }
        }
        
        return usersToShow
    }
    var _workouts = [("Squats","Axel","3x50"),("Pushups","Axel","3x20"),("Pullups","Axel","3x10")]
    static var workouts: [(String, String, String)] {
        return self.shared._workouts
    }
    
    public static func performInitialSetup(completionHandler: (Void) -> Void) {
        
        users = LocalStorageManager.getAllUsers()
        if users.count == 0 {
            LocalStorageManager.storeUser(with: "Axel", shouldBeShown: true)
        }
        users = LocalStorageManager.getAllUsers()
        
        completionHandler()
        
    }

}
