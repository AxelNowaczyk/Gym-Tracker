//
//  Exorcise+CoreDataProperties.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 05/02/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import Foundation
import CoreData


extension Exorcise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exorcise> {
        return NSFetchRequest<Exorcise>(entityName: "Exorcise");
    }

    @NSManaged public var name: String?
    @NSManaged public var wasPerformedIn: Take?

}
