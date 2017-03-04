//
//  ExorciseProvider.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 26/02/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import Foundation
import CoreData

class ExorciseProvider: BaseProvider {
    
    func storeExorcise(named name: String, in session: Session) -> Exorcise {
        if let exorcise = self.exorcise(named: name, in: session) {
            return exorcise
        }
        
        let exorcise = NSEntityDescription.insertNewObject(forEntityName: LocalStorageManager.exorciseModel, into: self.context) as! Exorcise
        exorcise.name = name
        exorcise.wasPerformedIn = session
        
        return exorcise
    }
    
    func exorcise(named name: String, in session: Session) -> Exorcise? {
        return session.including?.first(where: { ($0 as? Exorcise)?.name == name }) as! Exorcise?
    }
    
    func exorcises(in session: Session) -> [Exorcise] {
        guard   let sessionsSet = session.including,
                let sessions = Array(sessionsSet) as? [Exorcise] else {
            return []
        }
        
        return sessions
    }
    
    var exorcises: [Exorcise] {
        do {
            let exorcises = try self.context.fetch(NSFetchRequest(entityName: LocalStorageManager.exorciseModel))
            let uniqueExorcises = Array(Set(exorcises as! [Exorcise]))
            return uniqueExorcises
        } catch {
            print(error)
        }
        return []
    }

    var exorciseNames: [String] {
        let exorcisesStringNames = exorcises.map() { $0.name! }
        let uniqueNames = exorcisesStringNames.reduce([]) { ac, name in
            ac.contains(where: { $0 == name }) ? ac : ac + [name]
        }
        return uniqueNames
    }
    
}
