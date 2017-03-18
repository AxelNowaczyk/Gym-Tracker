//
//  AlertUtil.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 27/02/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import Foundation
import UIKit

class AlertUtil {
    
    static func createBasicAlert(with title: String, message: String) -> UIAlertController {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
        return alertController
        
    }
    
    typealias AlertWithTextFieldResponse = (String) -> Void
    static func createAlertWithTextField(title: String, message: String, textFieldPlaceholder: String, withText text: String?, textFieldTextWhenSubmit: @escaping AlertWithTextFieldResponse) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
        alertController.addTextField { (textField: UITextField) in
            textField.keyboardType = .default
            textField.text = text
            textField.placeholder = textFieldPlaceholder
            textField.clearButtonMode = .whileEditing
        }
        let submitAction = UIAlertAction(title: "Submit", style: .default, handler: { (action) -> Void in
            if let textfieldValue = alertController.textFields?[0].text {
                textFieldTextWhenSubmit(textfieldValue)
            } else {
                textFieldTextWhenSubmit("Unknown")
            }
        })

        alertController.addAction(submitAction)
        alertController.addAction(cancelAction)
        
        return alertController
    }
    

    
}
