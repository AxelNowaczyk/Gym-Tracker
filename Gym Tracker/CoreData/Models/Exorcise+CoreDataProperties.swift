//
//  Exorcise+CoreDataProperties.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 15/01/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import Foundation
import CoreData


extension Exorcise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exorcise> {
        return NSFetchRequest<Exorcise>(entityName: "Exorcises");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var result: String?
    @NSManaged public var name: String?
    @NSManaged public var wasDone: Users?

}
