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

class PictureProvider: BaseProvider {
    
    func storePictureForExorcise(named name: String, image: UIImage) {
        var picture: Picture! = retrievePictureModelForExorcise(named: name)
        if picture == nil {
            picture = NSEntityDescription.insertNewObject(forEntityName: LocalStorageManager.pictureModel, into: self.context) as! Picture
            picture.exorciseName = name
        }
        let jpegImage = UIImageJPEGRepresentation(image, 0.0)
        picture.pictureData = jpegImage as NSData?
    }
    
    func changeName(oldName: String, newName: String) {
        guard   let picture = retrievePictureModelForExorcise(named: oldName) else {
                return
        }
        picture.exorciseName = newName
    }

    func deletePictureForExorcise(named name: String) {
        guard   let picture = retrievePictureModelForExorcise(named: name) else {
            return
        }
        context.delete(picture)
    }
    
    func retrievePictureForExorcise(named name: String?) -> UIImage? {
        guard   let picture = retrievePictureModelForExorcise(named: name),
                let pictureData = picture.pictureData as Data? else {
            return nil
        }
        return UIImage(data: pictureData)
    }
    
    private func retrievePictureModelForExorcise(named name: String?) -> Picture? {
        guard let name = name else {
            return nil
        }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: LocalStorageManager.pictureModel)
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "exorciseName == %@", name)
        
        do {
            let pictures = try self.context.fetch(fetchRequest)
            return pictures.first as? Picture
        } catch {
            return nil
        }
    }
    
}
