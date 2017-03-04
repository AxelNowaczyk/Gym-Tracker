//
//  AddWorkoutViewController.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 30/01/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import UIKit

class AddWorkoutViewController: UIViewController {
    
    @IBOutlet var userPickerView: UIPickerView!
    @IBOutlet var weightPickerView: UIPickerView!
    @IBOutlet var exorcisePictureImageView: UIImageView!
    @IBOutlet var previousWorkoutTableView: UITableView!
    @IBOutlet var currentWorkoutTableView: UITableView!
    @IBOutlet var repsTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    
    @IBAction func cancelButtonWasTouched(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addButtonWasTouched(_ sender: UIButton) {
        
        guard   let reps = Int(repsTextField.text ?? ""),
                let weight = Double(weightTextField.text ?? ""),
                reps != 0 && weight != 0 else {
                
                    let alert = AlertUtil.createBasicAlert(with: "OOPS", message: "You need to provide both weight and rips number to add workout.")
                    self.present(alert, animated: true, completion: nil)
                    return
        }

//        guard let lastSession = lastSession else {
//            return
//        }
//        
//        sessionProvider.addSet(performig: reps, with: weight, in: lastSession, for: exorcise)
    }
    
    
    fileprivate enum PickerViewTag: Int {
        case user = 1
        case weight = 2
    }

    fileprivate enum TableViewTag: Int {
        case previous = 1
        case current = 2
    }
    
    
    var exorciseName: String?
    var sessionManager: SessionManager?
    let userProvider = UserProvider()
    let exorciseRovider = ExorciseProvider()
    let weightConverter = WeightConverter()
    
    var users: [User] = [] {
        didSet {
            userPickerView.reloadAllComponents()
            reloadData()
        }
    }
    
    var user: User {
        return users[userPickerView.selectedRow(inComponent: 0)]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        users = userProvider.users
    }
    
    fileprivate func reloadData() {

        clearTextFields()
        previousWorkoutTableView.reloadData()
        currentWorkoutTableView.reloadData()
        
    }
    
    private func clearTextFields() {
        weightTextField.text = ""
        repsTextField.text = ""
    }

}

extension AddWorkoutViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        guard let pickerViewTag = PickerViewTag(rawValue: pickerView.tag) else {
            return 0
        }
        
        switch pickerViewTag {
        case .user:
            return users.count
        case .weight:
            return weightConverter.numberOfWeighTypes
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        guard let pickerViewTag = PickerViewTag(rawValue: pickerView.tag) else {
            return "Unknown"
        }
        
        switch pickerViewTag {
        case .user:
            return users[row].name ?? "Unknown"
        case .weight:
            return weightConverter.getWeightType(at: row).description
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        reloadData()
    }
}
