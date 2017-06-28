//
//  PictureProvider.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 08/04/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//


import Foundation
import UIKit
import CoreData

class PictureProvider: NSObject {
    
    static func storePictureForexercise(named name: String, image: UIImage) {
        var picture: Picture! = retrievePictureModelForexercise(named: name)
        if picture == nil {
            picture = NSEntityDescription.insertNewObject(forEntityName: LocalStorageManager.pictureModel, into: CoreDataStack.shared.managedObjectContext) as! Picture
            picture.exerciseName = name
        }
        let jpegImage = UIImageJPEGRepresentation(image, 0.0)
        picture.pictureData = jpegImage as NSData?
    }
    
    static func changeName(oldName: String, newName: String) {
        guard   let picture = retrievePictureModelForexercise(named: oldName) else {
                return
        }
        picture.exerciseName = newName
    }

    static func deletePictureForexercise(named name: String) {
        guard   let picture = retrievePictureModelForexercise(named: name) else {
            return
        }
        CoreDataStack.shared.managedObjectContext.delete(picture)
    }
    
    static func retrievePictureForexercise(named name: String?) -> UIImage? {
        guard   let picture = retrievePictureModelForexercise(named: name),
                let pictureData = picture.pictureData as Data? else {
            return nil
        }
        return UIImage(data: pictureData)
    }
    
    private static func retrievePictureModelForexercise(named name: String?) -> Picture? {
        guard let name = name else {
            return nil
        }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: LocalStorageManager.pictureModel)
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "exerciseName == %@", name)
        
        return (try? CoreDataStack.shared.managedObjectContext.fetch(fetchRequest))?.first as? Picture
    }
}
