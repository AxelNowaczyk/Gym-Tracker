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
    
    static func getAllUsers() -> [User] {
        
        do {
            let users = try self.context.fetch(NSFetchRequest(entityName: LocalStorageManager.userModel))
            return (users as! [User])
            
        } catch {
            print(error)
        }
        return []
    }
    
    static func storeUser(with name: String, shouldBeShown: Bool = false) {
        let user = NSEntityDescription.insertNewObject(forEntityName: LocalStorageManager.userModel, into: self.context) as! User
        user.name = name
        user.isShowing = shouldBeShown
    }
}
