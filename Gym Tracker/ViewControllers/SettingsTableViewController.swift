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
        let alert = AlertUtil.createAlertWithTextField( title: "\("Alert_Add_user_Title".localized): ",
                                                        message: "",
                                                        textFieldPlaceholder: "Alert_Add_user_Placeholder".localized, withText: nil) { [weak self] textFieldText in
                                                            
                                                            guard textFieldText.characters.count > 0 else {
                                                                return
                                                            }
                                                            
                                                            guard self?.users.first(where: { $0.name == textFieldText }) == nil else {
                                                                return
                                                            }
                                                            
                                                            let newUser = UserProvider.storeUser(named: textFieldText)
                                                            self?.users.append(newUser)
                                                            CoreDataStack.shared.save()
                                                            
        }
        present(alert, animated: true, completion: nil)
    
    }
    
    private let userProvider = UserProvider()
    fileprivate var users: [User] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    var rowHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        users = UserProvider.users.sorted { $0.name! < $1.name! }
    }
}

extension SettingsTableViewController {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Users_Title".localized
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Users_Footer".localized
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.reuseIdentifier, for: indexPath)
        
        if let cell = cell as? SettingsTableViewCell {
            let user = users[indexPath.row]
            cell.setup(for: user.name!, hidden: user.hidden) { newValue in
                user.hidden = !newValue
                CoreDataStack.shared.save()
            }
        }
        
        return cell
    }
    
}


