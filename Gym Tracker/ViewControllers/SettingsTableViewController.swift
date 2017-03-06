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
    
    fileprivate let cellHeight: CGFloat = 44
    fileprivate let userProvider = UserProvider()
    fileprivate var users: [User] = [] {
        didSet {
            usersTableView.reloadData()
        }
    }
    
    fileprivate enum CellType: String {
        case basic = "Settings User Cell"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        users = userProvider.users
    }
    

}

extension SettingsTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if tableView == usersTableView {
            return 1
        } else {
            return super.numberOfSections(in: tableView)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == usersTableView {
            return users.count
        } else {
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == usersTableView {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: CellType.basic.rawValue, for: indexPath) as! SettingsTableViewCell
            print("users: \(users.count), row: \(indexPath.row)")
            let user = users[indexPath.row]
            cell.setup(for: user.name, hidden: user.hidden)
            cell.delegate = self
            
            return cell
            
        } else {
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == usersTableView {
            return cellHeight
        } else {
            return super.tableView(tableView, heightForRowAt: indexPath) //users.count < 10 ? cellHeight * CGFloat(users.count) : cellHeight * 10
        }
    }
    
}

extension SettingsTableViewController: SettingsTableViewCellDelegate {
    func cellDidChangeStatus(cell: SettingsTableViewCell, for userName: String, to status: Bool) {
        let user = users.first(where: { $0.name == userName })
        user?.hidden = !status
        userProvider.saveContest()
    }
}
