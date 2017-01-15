//
//  Users+CoreDataProperties.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 29/12/2016.
//  Copyright © 2016 Axel Nowaczyk. All rights reserved.
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users");
    }

    @NSManaged public var name: String?
    @NSManaged public var isShowing: Bool

}
