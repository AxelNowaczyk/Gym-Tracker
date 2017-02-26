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
    
    func storeExorcise(named name: String) -> Exorcise {
        let exorcise = NSEntityDescription.insertNewObject(forEntityName: LocalStorageManager.exorciseModel, into: self.context) as! Exorcise
        exorcise.name = name
        
        return exorcise
    }
    
    func getExorcise(named name: String) -> Exorcise? {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: LocalStorageManager.exorciseModel)
        fetchRequest.predicate = NSPredicate(format: "%K = %@", "name", name)
        fetchRequest.fetchLimit = 1
        
        do {
            let exorcises = try self.context.fetch(NSFetchRequest(entityName: LocalStorageManager.exorciseModel))
            return exorcises.first as? Exorcise
        } catch {
            return nil
        }
        
    }
    
}
