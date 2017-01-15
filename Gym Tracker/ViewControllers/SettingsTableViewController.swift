//
//  SettingsTableViewController.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 15/01/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBOutlet var usersTableView: UITableView!
    
    private enum Cell: String {
        case basic = "Settings User Cell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if tableView == usersTableView {
            return 1
        } else {
            return super.numberOfSections(in: tableView)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == usersTableView {
            return AppManager.users.count
        } else {
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == usersTableView {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Cell.basic.rawValue, for: indexPath) as! SettingsTableViewCell
            setupTableViewCell(with: cell, for: indexPath)
            return cell
            
        } else {
            return super.tableView(tableView, cellForRowAt: indexPath)
        }

    }
    
    private func setupTableViewCell(with cell: SettingsTableViewCell, for indexPath: IndexPath) {
        
        cell.nameLabel.text = AppManager.users[indexPath.row].name
        cell.visibilitySwitch.isOn = AppManager.users[indexPath.row].isShowing

    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == usersTableView {
            return nil
        } else {
            return super.tableView(tableView, titleForHeaderInSection: section)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if tableView == usersTableView {
            return ""
        } else {
            return super.tableView(tableView, titleForFooterInSection: section)
        }
    }
    
}
