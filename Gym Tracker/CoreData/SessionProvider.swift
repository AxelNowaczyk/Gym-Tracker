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
    
    func storeSession(with date: Date? = nil) -> Session {
        
        let session = NSEntityDescription.insertNewObject(forEntityName: LocalStorageManager.sessionModel, into: self.context) as! Session
        session.date = date as NSDate?? ?? NSDate()
        
        return session
    }
    
    func addSet(performig repsNumber: Int, with weight: Double, in session: Session, for exorcise: Exorcise) {
        _ = TakeProvider().storeTake(repsNumber: repsNumber, weight: weight, exorcise: exorcise, for: session)
    }
    
    func getLastSession() -> Session? {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: LocalStorageManager.sessionModel)
        fetchRequest.fetchLimit = 1
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        do {
            let exorcises = try self.context.fetch(NSFetchRequest(entityName: LocalStorageManager.sessionModel))
            return exorcises.first as? Session
        } catch {
            return nil
        }
        
    }

    func getLastSession(user: User) -> Session? {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: LocalStorageManager.sessionModel)
        fetchRequest.fetchLimit = 1
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        fetchRequest.predicate = NSPredicate(format: "ALL wasPerformedBy == %@", user)
        
        do {
            let exorcises = try self.context.fetch(NSFetchRequest(entityName: LocalStorageManager.sessionModel))
            return exorcises.first as? Session
        } catch {
            return nil
        }
    }
    
    func getLastSession(for exorcise: Exorcise) -> Session? {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: LocalStorageManager.sessionModel)
        fetchRequest.fetchLimit = 1
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        fetchRequest.predicate = NSPredicate(format: "ALL session.including.wasPerforming == %@", exorcise)
    
        do {
            let exorcises = try self.context.fetch(NSFetchRequest(entityName: LocalStorageManager.sessionModel))
            return exorcises.first as? Session
        } catch {
            return nil
        }
    }

    func getAllSessions() -> [Session] {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: LocalStorageManager.sessionModel)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        do {
            let sessions = try self.context.fetch(fetchRequest)
            return (sessions as? [Session]) ?? []
            
        } catch {
            print(error)
        }
        return []
        
    }
//    
//    func getAllSessions(for exorcise: Exorcise) -> [Session] {
//        
//    }
}
