//
//  Session+CoreDataProperties.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 05/02/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Session {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Session> {
        return NSFetchRequest<Session>(entityName: "Session");
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var including: Take?
    @NSManaged public var wasPerformedBy: Users?

}
