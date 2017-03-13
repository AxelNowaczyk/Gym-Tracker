//
//  Persistence.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 27/01/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import Foundation
import CoreData

class Persistence: NSObject {
    
    fileprivate var manageObjectModel:NSManagedObjectModel! = nil
    fileprivate var persistentStoreCoordinator:NSPersistentStoreCoordinator! = nil
    
    var managedObjectContext:NSManagedObjectContext! = nil
    
    override init() {
        
        super.init()
        self.setupDatabase()
    }
    
    //MARK: life cycle
    
    func coordinator() -> NSPersistentStoreCoordinator {
        
        return persistentStoreCoordinator
    }
    
    fileprivate func persistentStoreCommonOptions() -> [AnyHashable: Any] {
        
        return [NSMigratePersistentStoresAutomaticallyOption: 1,
                NSInferMappingModelAutomaticallyOption: 1,
                NSSQLitePragmasOption: ["journal_mode":"DELETE"]]
    }
    
    fileprivate func defaultPersistentStoreURL() -> URL {
        
        let manager = FileManager.default
        let documentDirectoryURL = manager.urls(for: .documentDirectory, in: .userDomainMask).last
        
        return documentDirectoryURL!.appendingPathComponent("GymTracker.sqlite")
    }
    
    func setupDatabase() {
        
        let persistentStoreURL = self.defaultPersistentStoreURL()
        let modelURL = Bundle.main.url(forResource: "CoreDataModel", withExtension: "momd")
        
        self.manageObjectModel = NSManagedObjectModel(contentsOf: modelURL!)
        self.persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.manageObjectModel)
        
        let options = self.persistentStoreCommonOptions()
        
        do {
            let storeMetadata = try NSPersistentStoreCoordinator.metadataForPersistentStore(ofType: NSSQLiteStoreType, at: persistentStoreURL, options: options)
            
            if self.manageObjectModel.isConfiguration(withName: nil, compatibleWithStoreMetadata: storeMetadata) == false {
                
                try FileManager.default.removeItem(atPath: persistentStoreURL.path)
            }
            
        }
        catch {
            print("No database - creating new")
        }
        
        do {
            _ = try self.persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                                       configurationName: nil,
                                                                       at: persistentStoreURL,
                                                                       options: options)
            
            self.managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            self.managedObjectContext?.persistentStoreCoordinator = self.persistentStoreCoordinator
            self.managedObjectContext?.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        }
        catch {
            fatalError("Error while trying to setup database")
        }
    }
    
    func save() -> Void {
        
        guard self.persistentStoreCoordinator.persistentStores.count == 0 else {
            print("Persistent store does not exist!")
            return
            
        }
        
        guard let managedObjectContext = self.managedObjectContext else {
            print("managedObjectContext does not exist!")
            return
        }
        
        
        managedObjectContext.perform { () -> Void in
            
            if managedObjectContext.hasChanges {
                do {
                    try managedObjectContext.save()
                }
                catch {
                    print("Error while saving database: \(error)")
                }
            }
        }
    }
}

