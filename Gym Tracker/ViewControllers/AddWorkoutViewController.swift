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
    @IBOutlet var exorciseImageView: UIImageView!
    
    @IBAction func clearButtonWasTouched(_ sender: UIButton) {
        clearTextFields()
    }
    
    @IBAction func addButtonWasTouched(_ sender: UIButton) {
        
        guard   let reps = Int(repsTextField.text ?? ""),
                let weight = Double(weightTextField.text ?? ""),
                reps != 0 && weight != 0 else {
                
                    let alert = AlertUtil.createBasicAlert(with: "OOPS", message: "You need to provide both weight and rips number to add workout.")
                    self.present(alert, animated: true, completion: nil)
                    return
        }
        let weightKG = weightConverter.convert(weight: weight, from: selectedWeightType, to: .kg)
        _ = TakeProvider().storeTake(repsNumber: reps, weight: weightKG, for: exorcise)
        currentWorkoutTableView.reloadData()

    }

    fileprivate enum PickerViewTag: Int {
        case user   = 1
        case weight = 2
    }

    fileprivate enum TableViewTag: Int {
        case previous   = 1
        case current    = 2
    }
    
    fileprivate enum CellIdentifiers: String {
        case addWorkoutCell = "AddWorkoutTableViewCell"
    }
    fileprivate let cellHeigh: CGFloat = 44
    var exorciseName: String!
    var exorcise: Exorcise {
        let sessionManager = SessionManager(user: user, exorciseName: exorciseName)
        return ExorciseProvider().storeExorcise(named: exorciseName, in: sessionManager.currentSession)
    }
    
    var previousExorcise: Exorcise? {
        let sessionManager = SessionManager(user: user, exorciseName: exorciseName)
        guard let previousSession = sessionManager.previousSession else {
            return nil
        }
        return ExorciseProvider().storeExorcise(named: exorciseName, in: previousSession)
    }
    
    var currentTakes: [Take] {
        return (Array(exorcise.consistsOf!) as? [Take]) ?? []
    }
    
    var previousTakes: [Take] {
        guard let previousExorcise = previousExorcise else {
            return []
        }
        return (Array(previousExorcise.consistsOf!) as? [Take]) ?? []
    }
    
    var lastSelectedWeightType: WeightType!
    var selectedWeightType: WeightType {
        return WeightType.allValues[weightPickerView.selectedRow(inComponent: 0)]
    }
    
    let userProvider = UserProvider()
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
    
    deinit {
        view.unbindFromKeyboard()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: CellIdentifiers.addWorkoutCell.rawValue, bundle: nil)
        currentWorkoutTableView.register(nib, forCellReuseIdentifier: CellIdentifiers.addWorkoutCell.rawValue)
        previousWorkoutTableView.register(nib, forCellReuseIdentifier: CellIdentifiers.addWorkoutCell.rawValue)
        
        self.title = exorciseName
        lastSelectedWeightType = selectedWeightType
        
        setupImageView()
        view.bindToKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        users = userProvider.users
    }
    
    fileprivate func reloadData() {
        previousWorkoutTableView.reloadData()
        currentWorkoutTableView.reloadData()
    }
    
    fileprivate func updateWeighstIfNeeded() {
        guard   let weightString = weightTextField.text,
            let weight = Double(weightString) else {
                return
        }
        
        let newWeight = weightConverter.convert(weight: weight, from: lastSelectedWeightType, to: selectedWeightType)
        weightTextField.text = "\((newWeight*100).rounded()/100)"
    }
    
    fileprivate func clearTextFields() {
        weightTextField.text = ""
        repsTextField.text = ""
    }

    
    fileprivate func setupImageView() {
        exorciseImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(exorciseImageWasTapped))
        exorciseImageView.addGestureRecognizer(tapGesture)
        
    }
    
    func exorciseImageWasTapped(_ sender: UITapGestureRecognizer) {
        
        let alertController = UIAlertController(title: "Select picture for this exorcise.", message: nil, preferredStyle: .actionSheet)
        
        let alertActionPhotoLibrary = UIAlertAction(title: "Photo Library", style: .default) { _ in
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = .photoLibrary
            
            self.present(picker, animated: true, completion: nil)
        }
        let alertActionCamera = UIAlertAction(title: "Camera", style: .default) { _ in
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = .camera
            
            self.present(picker, animated: true, completion: nil)
        }
        let alertActionCancel = UIAlertAction(title: "Cancel", style: .destructive) { _ in }
        
        alertController.addAction(alertActionPhotoLibrary)
        alertController.addAction(alertActionCamera)
        alertController.addAction(alertActionCancel)
        
        self.present(alertController, animated: true, completion: nil)
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
        guard let pickerViewTag = PickerViewTag(rawValue: pickerView.tag) else {
            return
        }
        
        switch pickerViewTag {
        case .user:
            clearTextFields()
            fallthrough
        case .weight:
            updateWeighstIfNeeded()
            fallthrough
        case .user,
             .weight:
            reloadData()
        }
        
        lastSelectedWeightType = selectedWeightType
    }
    
}

extension AddWorkoutViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tableViewTag = TableViewTag(rawValue: tableView.tag) else {
            return 0
        }
        
        switch tableViewTag {
        case .current:
            return currentTakes.count
        case .previous:
            return previousTakes.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.addWorkoutCell.rawValue) as! AddWorkoutTableViewCell
        cell.weightSmallLabel.text = "Weight [\(selectedWeightType.description)]"
        
        guard let tableViewTag = TableViewTag(rawValue: tableView.tag) else {
            return cell
        }
        
        switch tableViewTag {
        case .current:
            cell.repsBigLabel.text = "\(currentTakes[indexPath.row].repsNumber)"
            let weight = weightConverter.convert(weight: currentTakes[indexPath.row].weight, from: .kg, to: selectedWeightType)
            cell.weightBigLabel.text = "\((weight*100).rounded()/100)"
        case .previous:
            cell.repsBigLabel.text = "\(previousTakes[indexPath.row].repsNumber)"
            let weight = weightConverter.convert(weight: previousTakes[indexPath.row].weight, from: .kg, to: selectedWeightType)
            cell.weightBigLabel.text = "\((weight*100).rounded()/100)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard let tableViewTag = TableViewTag(rawValue: tableView.tag) else {
            return false
        }
        
        switch tableViewTag {
        case .current:
            return true
        case .previous:
            return false
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let takeToRemove = currentTakes[indexPath.row]
        TakeProvider().delete(take: takeToRemove)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeigh
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tableViewTag = TableViewTag(rawValue: tableView.tag) else {
            return
        }
        
        var take: Take
        switch tableViewTag {
        case .current:
            take = currentTakes[indexPath.row]
        case .previous:
            take = previousTakes[indexPath.row]
        }
        weightTextField.text = "\(take.weight)"
        repsTextField.text = "\(take.repsNumber)"
    }
}

extension AddWorkoutViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension AddWorkoutViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else { return }
        exorciseImageView.image = image
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension AddWorkoutViewController: UINavigationControllerDelegate { }
