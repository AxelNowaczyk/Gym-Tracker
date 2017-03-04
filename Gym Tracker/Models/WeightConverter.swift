//
//  WeightConverter.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 03/03/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import Foundation

enum WeightType: Double {
    case kg = 1
    case lbs = 0.4536
    
    static let allValues: [WeightType] = [
        .kg,
        .lbs]
}

extension WeightType: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .kg:
            return "kg"
        case .lbs:
            return "lbs"
        }
    }
}

class WeightConverter {
    
    var numberOfWeighTypes: Int {
        return WeightType.allValues.count
    }
    
    func getWeightType(at index: Int) -> WeightType {
        return WeightType.allValues[index]
    }
    
    func convert(weight: Double, from type1: WeightType, to type2: WeightType) -> Double {
        return weight * type1.rawValue / type2.rawValue
    }
    
}
