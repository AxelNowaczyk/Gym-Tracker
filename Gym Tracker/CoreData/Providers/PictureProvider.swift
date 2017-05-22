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
    
    static func storePictureForExorcise(named name: String, image: UIImage) {
        var picture: Picture! = retrievePictureModelForExorcise(named: name)
        if picture == nil {
            picture = NSEntityDescription.insertNewObject(forEntityName: LocalStorageManager.pictureModel, into: CoreDataStack.shared.managedObjectContext) as! Picture
            picture.exorciseName = name
        }
        let jpegImage = UIImageJPEGRepresentation(image, 0.0)
        picture.pictureData = jpegImage as NSData?
    }
    
    static func changeName(oldName: String, newName: String) {
        guard   let picture = retrievePictureModelForExorcise(named: oldName) else {
                return
        }
        picture.exorciseName = newName
    }

    static func deletePictureForExorcise(named name: String) {
        guard   let picture = retrievePictureModelForExorcise(named: name) else {
            return
        }
        CoreDataStack.shared.managedObjectContext.delete(picture)
    }
    
    static func retrievePictureForExorcise(named name: String?) -> UIImage? {
        guard   let picture = retrievePictureModelForExorcise(named: name),
                let pictureData = picture.pictureData as Data? else {
            return nil
        }
        return UIImage(data: pictureData)
    }
    
    private static func retrievePictureModelForExorcise(named name: String?) -> Picture? {
        guard let name = name else {
            return nil
        }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: LocalStorageManager.pictureModel)
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "exorciseName == %@", name)
        
        return (try? CoreDataStack.shared.managedObjectContext.fetch(fetchRequest))?.first as? Picture
    }
}
