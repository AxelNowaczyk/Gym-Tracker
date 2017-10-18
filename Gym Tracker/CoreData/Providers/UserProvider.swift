//
//  UserProvider.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 26/02/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import Foundation
import CoreData

class UserProvider: NSObject {

    static func storeUser(named name: String, hidden: Bool = false) -> User {
        let user = NSEntityDescription.insertNewObject(forEntityName: CoreDataModelType.user.rawValue, into: CoreDataStack.shared.managedObjectContext) as! User
        user.name = name
        user.hidden = hidden
        
        return user
    }
    
    static func user(named name: String?) -> User? {
        guard let name = name else {
            return nil
        }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataModelType.user.rawValue)
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        return (try? CoreDataStack.shared.managedObjectContext.fetch(fetchRequest))?.first as? User
    }
    
    static var users: [User] {
        return (try? CoreDataStack.shared.managedObjectContext.fetch(NSFetchRequest(entityName: CoreDataModelType.user.rawValue))) as? [User] ?? []
    }
    
    static var usersToDisplay: [User] {
        
        var usersToShow = [User]()
        for user in users where !user.hidden {
            usersToShow.append(user)
        }
        
        return usersToShow
    }

}
