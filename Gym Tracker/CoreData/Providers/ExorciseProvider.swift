//
//  ExorciseProvider.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 26/02/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import Foundation
import CoreData

class ExorciseProvider: NSObject {
    
    static func storeExorcise(named name: String, in session: Session) -> Exorcise {
        if let exorcise = self.exorcise(named: name, in: session) {
            return exorcise
        }
        
        let exorcise = NSEntityDescription.insertNewObject(forEntityName: LocalStorageManager.exorciseModel, into: CoreDataStack.shared.managedObjectContext) as! Exorcise
        exorcise.name = name
        exorcise.wasPerformedIn = session
        return exorcise
    }
    
    static func exorcise(named name: String, in session: Session) -> Exorcise? {
        return session.including?.first { ($0 as? Exorcise)?.name == name } as! Exorcise?
    }
    
    static func exorcises(in session: Session) -> [Exorcise] {
        guard   let sessionsSet = session.including,
                let sessions = Array(sessionsSet) as? [Exorcise] else {
            return []
        }
        
        return sessions
    }
    
    static func removeExorcices(named name: String) {
        TakeProvider.deleteAllTakesForExorcise(named: name)
        exorcises
            .filter { $0.name == name }
            .forEach { CoreDataStack.shared.managedObjectContext.delete($0) }
    }

    static func changeNameForExorcices(named name: String, with newName: String) {
        exorcises
            .filter { $0.name == name }
            .forEach { $0.name = newName }
    }
    
    static func removeExorcisesWithNoTakes(completionHandler: (Void) -> ()) {
        exorcises
            .filter { $0.consistsOf?.count == 0 }
            .forEach { CoreDataStack.shared.managedObjectContext.delete($0) }
        completionHandler()
    }
    
    static var exorcises: [Exorcise] {
        guard let exorcises = try? CoreDataStack.shared.managedObjectContext.fetch(NSFetchRequest(entityName: LocalStorageManager.exorciseModel)) else {
            return []
        }
        let uniqueExorcises = Array(Set(exorcises as! [Exorcise]))
        return uniqueExorcises.sorted { $0.name! < $1.name! }
    }

    static var exorciseNames: [String] {
        let exorcisesStringNames = exorcises.map() { $0.name! }
        let uniqueNames = exorcisesStringNames.reduce([]) { ac, name in
            ac.contains(where: { $0 == name }) ? ac : ac + [name]
        }
        return uniqueNames
    }
    
}
