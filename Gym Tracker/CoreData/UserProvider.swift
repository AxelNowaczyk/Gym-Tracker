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
    
    func user(named name: String?) -> User? {
        guard let name = name else {
            return nil
        }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: LocalStorageManager.userModel)
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        return (try? self.context.fetch(fetchRequest))?.first as? User
    }
    
    var users: [User] {
        return (try? self.context.fetch(NSFetchRequest(entityName: LocalStorageManager.userModel))) as? [User] ?? []
    }
    
    var usersToDisplay: [User] {
        
        var usersToShow = [User]()
        for user in users where !user.hidden {
            usersToShow.append(user)
        }
        
        return usersToShow
    }

}
