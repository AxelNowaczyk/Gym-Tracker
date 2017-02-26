//
//  LocalStorageManager.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 15/01/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct LocalStorageManager {
    
    static let userModel = "User"
    static let sessionModel = "Session"
    static let takeModel = "Take"
    static let exorciseModel = "Exorcise"
    
}

class BaseProvider: NSObject {
    static var context: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    }
}

