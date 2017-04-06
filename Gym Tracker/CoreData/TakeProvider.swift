//
//  TakeProvider.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 26/02/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import Foundation
import CoreData

class TakeProvider: BaseProvider {
    
    var takes: [Take] {
        do {
            let takes = try self.context.fetch(NSFetchRequest(entityName: LocalStorageManager.takeModel))
            return takes as? [Take] ?? []
        } catch {
            print(error)
        }
        return []
    }
    
    func storeTake(repsNumber: Int, weight: Double, for exorcise: Exorcise) -> Take {
        let take = NSEntityDescription.insertNewObject(forEntityName: LocalStorageManager.takeModel, into: self.context) as! Take
        
        take.repsNumber = Int16(repsNumber)
        take.weight = weight
        
        take.wasIncludedIn = exorcise

        saveContext()
        return take
    }

    func deleteAllTakesForExorcise(named name: String) {
        takes
            .filter { $0.wasIncludedIn?.name == name }
            .forEach { context.delete($0) }
        saveContext()
    }
    
    func delete(take: Take) {
        context.delete(take)
        saveContext()
    }
}
