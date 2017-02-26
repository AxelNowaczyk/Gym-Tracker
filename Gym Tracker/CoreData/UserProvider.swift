//
//  UserProvider.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 26/02/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import Foundation
import CoreData

class UserProvider: BaseProvider {

    func storeUser(with name: String, shouldBeShown: Bool = false) {
        let user = NSEntityDescription.insertNewObject(forEntityName: LocalStorageManager.userModel, into: self.context) as! User
        user.name = name
        user.isShowing = shouldBeShown
    }
    
    func getAllUsers() -> [User] {
        
        do {
            let users = try self.context.fetch(NSFetchRequest(entityName: LocalStorageManager.userModel))
            return (users as! [User])
            
        } catch {
            print(error)
        }
        return []
    }
    
    func getUsersToDisplay() -> [User] {
        
        var usersToShow = [User]()
        for user in getAllUsers() {
            if user.isShowing {
                usersToShow.append(user)
            }
        }
        
        return usersToShow
    }

}
