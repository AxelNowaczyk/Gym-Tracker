//
//  LocalStorageManager.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 15/01/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class LocalStorageManager: NSObject {
    
    static let shared = LocalStorageManager()
    
    private struct Strings {
        static let users = "Users"
    }
    
    
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var context: NSManagedObjectContext {
        return appDelegate.managedObjectContext
    }
    
    static func getAllUsers() -> [Users] {
        
        do {
            let users = try self.shared.context.fetch(NSFetchRequest(entityName: Strings.users))
            return (users as! [Users])
            
        } catch {
            print(error)
        }
        return []
    }
    
    static func storeUser(with name: String, shouldBeShown: Bool = false) {
        let user = NSEntityDescription.insertNewObject(forEntityName: Strings.users, into: self.shared.context) as! Users
        user.name = name
        user.isShowing = shouldBeShown
    }
    
    
    
}
