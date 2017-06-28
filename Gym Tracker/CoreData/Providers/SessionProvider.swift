//
//  SessionProvider.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 26/02/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import Foundation
import CoreData

class SessionProvider: NSObject {
    
    static func storeSession(for user: User, with date: Date? = nil) -> Session {
        
        let session = NSEntityDescription.insertNewObject(forEntityName: LocalStorageManager.sessionModel, into: CoreDataStack.shared.managedObjectContext) as! Session
        session.date = date as NSDate? ?? NSDate()
        user.addToPerformed(session)
        
        return session
    }

    static func getLastSessions(numberOfSessions: Int?, for user: User, performing exerciseName: String) -> [Session] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: LocalStorageManager.sessionModel)
        if let numberOfSessions = numberOfSessions {
            fetchRequest.fetchLimit = numberOfSessions
        }
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        fetchRequest.predicate = NSPredicate(format: "wasPerformedBy == %@ AND ANY including.name == %@", user, exerciseName)
  
        return (try? CoreDataStack.shared.managedObjectContext.fetch(fetchRequest)) as? [Session] ?? []

    }

}
