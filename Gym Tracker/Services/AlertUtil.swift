//
//  AlertUtil.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 27/02/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import Foundation
import UIKit

struct AlertUtil {
    
    static func createBasicAlert(with title: String, message: String) -> UIAlertController {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Alert_OK".localized, style: .default, handler: { _ in }))
        return alertController
        
    }
    
    typealias AlertWithTextFieldResponse = (String) -> Void
    static func createAlertWithTextField(title: String, message: String, textFieldPlaceholder: String, withText text: String?,
                                         textFieldTextWhenSubmit: @escaping AlertWithTextFieldResponse) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Alert_Cancel".localized, style: .destructive, handler: { (action) -> Void in })
        alertController.addTextField { (textField: UITextField) in
            textField.keyboardType = .default
            textField.text = text
            textField.placeholder = textFieldPlaceholder
            textField.clearButtonMode = .whileEditing
        }
        let submitAction = UIAlertAction(title: "Alert_Submit".localized, style: .default, handler: { (action) -> Void in
            if let textfieldValue = alertController.textFields?.first?.text {
                textFieldTextWhenSubmit(textfieldValue)
            } else {
                textFieldTextWhenSubmit("Alert_Unknown".localized)
            }
        })

        alertController.addAction(submitAction)
        alertController.addAction(cancelAction)
        
        return alertController
    }
    
}
