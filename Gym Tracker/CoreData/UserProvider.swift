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

    func storeUser(named name: String, hidden: Bool = false) -> User {
        let user = NSEntityDescription.insertNewObject(forEntityName: LocalStorageManager.userModel, into: self.context) as! User
        user.name = name
        user.hidden = hidden
        
        return user
    }
    
    func user(named name: String) -> User? {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: LocalStorageManager.userModel)
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "ALL name == %@", name)
        
        do {
            let users = try self.context.fetch(NSFetchRequest(entityName: LocalStorageManager.userModel))
            return users.first as? User
        } catch {
            return nil
        }
    }
    
    var users: [User] {
        do {
            let users = try self.context.fetch(NSFetchRequest(entityName: LocalStorageManager.userModel))
            return (users as? [User]) ?? []
            
        } catch {
            print(error)
        }
        return []
    }
    
    var usersToDisplay: [User] {
        
        var usersToShow = [User]()
        for user in users where !user.hidden {
            usersToShow.append(user)
        }
        
        return usersToShow
    }

}
