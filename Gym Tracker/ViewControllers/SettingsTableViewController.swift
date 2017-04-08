//
//  SettingsTableViewController.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 15/01/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBAction func addBarButtonItemWasTapped(_ sender: UIBarButtonItem) {
        let alert = AlertUtil.createAlertWithTextField( title: "Write name for a new user: ",
                                                        message: "",
                                                        textFieldPlaceholder: "User Name", withText: nil) { [weak self] textFieldText in
                                                            
                                                            if  self?.users.first(where: { $0.name == textFieldText }) == nil,
                                                                let newUser = self?.userProvider.storeUser(named: textFieldText){
                                                                    self?.users.append(newUser)
                                                            }
                                                            
        }
        present(alert, animated: true, completion: nil)
    
    }
    
    fileprivate let userProvider = UserProvider()
    fileprivate var users: [User] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    fileprivate struct CellType {
        static let basic = "SettingsTableViewCell"
    }
    
    var rowHeight: CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        users = userProvider.users.sorted { $0.name! < $1.name! }
    }
}

extension SettingsTableViewController {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Users"
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Select which users should be displayed in the application."
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellType.basic, for: indexPath)
        
        if let cell = cell as? SettingsTableViewCell {
            let user = users[indexPath.row]
            cell.setup(for: user.name!, hidden: user.hidden, switchFunction: { [weak self] newValue in
                user.hidden = !newValue
                self?.userProvider.saveContext()
            })
        }
        
        return cell
    }
    
}


