//
//  TakeProvider.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 26/02/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import Foundation
import CoreData

class TakeProvider: NSObject {
    
    static var takes: [Take] {
        return (try? CoreDataStack.shared.managedObjectContext.fetch(NSFetchRequest(entityName: LocalStorageManager.takeModel))) as? [Take] ?? []
    }
    
    static func storeTake(repsNumber: Int, weight: Double, for exorcise: Exorcise) -> Take {
        let take = NSEntityDescription.insertNewObject(forEntityName: LocalStorageManager.takeModel, into: CoreDataStack.shared.managedObjectContext) as! Take
        take.repsNumber = Int16(repsNumber)
        take.weight = weight
        take.wasIncludedIn = exorcise
        return take
    }

    static func deleteAllTakesForExorcise(named name: String) {
        takes
            .filter { $0.wasIncludedIn?.name == name }
            .forEach { CoreDataStack.shared.managedObjectContext.delete($0) }
    }
    
    static func delete(take: Take) {
        CoreDataStack.shared.managedObjectContext.delete(take)
    }
}
