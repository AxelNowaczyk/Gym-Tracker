//
//  TakeProvider.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 26/02/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import Foundation
import CoreData

class TakeProvider: BaseProvider {
    
    func storeTake(repsNumber: Int, weight: Double, exorcise: Exorcise, for session: Session) -> Take {
        let take = NSEntityDescription.insertNewObject(forEntityName: LocalStorageManager.takeModel, into: self.context) as! Take
        
        take.repsNumber = Int16(repsNumber)
        take.weight = weight
        
        take.wasIncludedIn = session
        take.wasPerforming = exorcise
        
        return take
    }

}
