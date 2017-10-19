//
//  exerciseProvider.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 26/02/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import Foundation
import CoreData

class ExerciseProvider: NSObject {
    
    static var exercises: [Exercise] {
        guard let exercises = try? CoreDataStack.shared.managedObjectContext.fetch(NSFetchRequest(entityName: CoreDataModelType.exercise.rawValue)) else {
            return []
        }
        let uniqueExercises = Array(Set(exercises as! [Exercise]))
        return uniqueExercises.sorted { $0.name! < $1.name! }
    }
    
    static var exerciseNames: [String] {
        let exercisesStringNames = exercises.map() { $0.name! }
        let uniqueNames = exercisesStringNames.reduce([]) { ac, name in
            ac.contains(where: { $0 == name }) ? ac : ac + [name]
        }
        return uniqueNames
    }
    
    static func storeExercise(named name: String, in session: Session) -> Exercise {
        if let exercise = self.exercise(named: name, in: session) {
            return exercise
        }
        
        let exercise = NSEntityDescription.insertNewObject(forEntityName: CoreDataModelType.exercise.rawValue, into: CoreDataStack.shared.managedObjectContext) as! Exercise
        exercise.name = name
        exercise.wasPerformedIn = session
        return exercise
    }
    
    static func exercise(named name: String, in session: Session) -> Exercise? {
        return session.including?.first { ($0 as? Exercise)?.name == name } as! Exercise?
    }
    
    static func exercises(in session: Session) -> [Exercise] {
        guard   let sessionsSet = session.including,
                let sessions = Array(sessionsSet) as? [Exercise] else {
            return []
        }
        
        return sessions
    }
    
    static func removeExorcices(named name: String) {
        TakeProvider.deleteAllTakesForexercise(named: name)
        exercises
            .filter { $0.name == name }
            .forEach { CoreDataStack.shared.managedObjectContext.delete($0) }
    }

    static func changeNameForExorcices(named name: String, with newName: String) {
        exercises
            .filter { $0.name == name }
            .forEach { $0.name = newName }
    }
    
    static func removeExercisesWithNoTakes(completionHandler: () -> Void) {
        exercises
            .filter { $0.consistsOf?.count == 0 }
            .forEach { CoreDataStack.shared.managedObjectContext.delete($0) }
        completionHandler()
    }
}
