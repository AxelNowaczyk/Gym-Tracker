//
//  Take+CoreDataProperties.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 05/02/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Take {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Take> {
        return NSFetchRequest<Take>(entityName: "Take");
    }

    @NSManaged public var repsNumber: Int16
    @NSManaged public var weight: Double
    @NSManaged public var wasIncludedIn: Session?
    @NSManaged public var wasPerforming: Exorcise?

}
