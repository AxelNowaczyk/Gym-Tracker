//
//  SessionProvider.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 26/02/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import Foundation
import CoreData

class SessionProvider: BaseProvider {
    
    func storeSession(for user: User, with date: Date? = nil) -> Session {
        
        let session = NSEntityDescription.insertNewObject(forEntityName: LocalStorageManager.sessionModel, into: self.context) as! Session
        session.date = date as NSDate?? ?? NSDate()
        user.addToPerformed(session)
        
        return session
    }

    func getLastSessions(numberOfSessions: Int, for user: User, performing exorcise: Exorcise) -> [Session] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: LocalStorageManager.sessionModel)
        fetchRequest.fetchLimit = numberOfSessions
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        fetchRequest.predicate = NSPredicate(format: "(wasPerformedBy == %@) AND (including == %@)", user, exorcise)
        
        do {
            let exorcises = try self.context.fetch(NSFetchRequest(entityName: LocalStorageManager.sessionModel))
            return exorcises as? [Session] ?? []
        } catch {
            return []
        }
    }

}
