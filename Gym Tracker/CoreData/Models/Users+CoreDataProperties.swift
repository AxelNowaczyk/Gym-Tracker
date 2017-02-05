//
//  Users+CoreDataProperties.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 05/02/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "User");
    }

    @NSManaged public var isShowing: Bool
    @NSManaged public var name: String?
    @NSManaged public var performed: Session?

}
