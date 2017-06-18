//
//  CoreDataStack.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 27/01/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack: NSObject {
    
    static var shared = CoreDataStack()
    
    var persistentStoreCoordinator: NSPersistentStoreCoordinator!
    var managedObjectContext: NSManagedObjectContext!
    
    fileprivate var defaultPersistentStoreURL: URL!
    fileprivate var managedObjectModel: NSManagedObjectModel!
    
    override init() {
        super.init()
        
        setupCoreData()
    }
    
    func save() {
        managedObjectContext.perform { () -> Void in
            if self.managedObjectContext.hasChanges {
                try? self.managedObjectContext.save()
            }
        }
    }
    
    fileprivate func setupCoreData() {
        setupManagedObjectModel()
        setupDefaultPersistentStoreURL()
        setupPersistentStoreCoordinator()
        setupManagedObjectContext()
    }

    fileprivate func setupManagedObjectModel() {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
            fatalError("No last element in file manager")
        }
        defaultPersistentStoreURL = url
    }
    
    fileprivate func setupDefaultPersistentStoreURL() {
        let modelURL = Bundle.main.url(forResource: "CoreDataModel", withExtension: "momd")!
        managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)!
    }
    
    fileprivate func setupPersistentStoreCoordinator() {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.defaultPersistentStoreURL.appendingPathComponent("GymTracker.sqlite")
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            var dict: [String: AnyObject] = [:]
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = "There was an error creating or loading the application's saved data." as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "GENERAL_DOMAIN", code: 9999, userInfo: dict)
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        persistentStoreCoordinator = coordinator
    }

    fileprivate func setupManagedObjectContext() {
        let coordinator = persistentStoreCoordinator
        let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        moc.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        moc.persistentStoreCoordinator = coordinator
        managedObjectContext = moc
    }

}

