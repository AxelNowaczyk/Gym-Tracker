//
//  MainHistoryViewController.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 11/03/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import UIKit
import Charts

class MainHistoryViewController: UIViewController {

    @IBOutlet var workoutTableView: UITableView!
    @IBOutlet var userTableView: UITableView!
    @IBOutlet var selectedUserLabel: UILabel!
    @IBOutlet var historyTableTabLabel: UILabel!
    @IBOutlet var chartTabLabel: UILabel!
    @IBOutlet var userTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var chartView: LineChartView!
    
    @IBAction func selectedUserLabelWasTapped(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 1) {
            let newHeight = self.userTableViewHeightConstraint.constant == self.tableViewHeight ? 0 : self.tableViewHeight
            self.userTableViewHeightConstraint.constant = newHeight
        }
    }
    
    @IBAction func tableTabWasTapped(_ sender: UITapGestureRecognizer) {
        selectedTab = .table
    }

    @IBAction func chartTabWasTapped(_ sender: UITapGestureRecognizer) {
        selectedTab = .chart
    }
    
    fileprivate var tableViewHeight: CGFloat {
        let numberOfCellsToDisplay = users.count > 4 ? 5 : users.count
        return 44 * CGFloat(numberOfCellsToDisplay)
    }
    
    fileprivate var selectedTab: TabType = .table {
        didSet {
            if selectedTab == .table {
                historyTableTabLabel.backgroundColor = selectedTabColor
                historyTableTabLabel.textColor       = .white
                chartTabLabel.backgroundColor        = notSelectedTabColor
                chartTabLabel.textColor              = .black
                scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            } else {
                historyTableTabLabel.backgroundColor = notSelectedTabColor
                historyTableTabLabel.textColor       = .black
                chartTabLabel.backgroundColor        = selectedTabColor
                chartTabLabel.textColor              = .white
                scrollView.setContentOffset(CGPoint(x: scrollView.bounds.width, y: 0), animated: false)
            }
            UIView.animate(withDuration: 1) {
                self.userTableViewHeightConstraint.constant = 0
            }
        }
    }
    fileprivate struct CellIdentifiers {
        static let user = "HistoryUserTableViewCell"
        static let sessionHeader = "HistoryTableViewHeader"
        static let exorcise = "AddWorkoutTableViewCell"
    }
    var userName: String? {
        didSet {
            selectedUserLabel.text = userName
            (tabBarController as? MainTabBarController)?.selectedUserName = userName
        }
    }
    var exorciseName: String?
    fileprivate let selectedTabColor: UIColor        = .black
    fileprivate let notSelectedTabColor: UIColor     = .white
    fileprivate enum TabType {
        case table
        case chart
    }
    fileprivate let sessionProvider     = SessionProvider()
    fileprivate let users               = UserProvider().usersToDisplay
    fileprivate var sessions: [Session] = [] {
        didSet {
            workoutTableView.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let mainTabBarController = tabBarController as? MainTabBarController else {
            return
        }
        
        if let exorciseName = mainTabBarController.selectedExorciseName {
            self.exorciseName = exorciseName
            title = exorciseName
        }
        
        if  let userName = mainTabBarController.selectedUserName {
            self.userName = userName
        }
        updateSessions()
        workoutTableView.reloadData()
        updateChart()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userTableViewHeightConstraint.constant = 0
        selectedTab = .table
        title = exorciseName
        userName = users.first?.name
        updateSessions()
        updateChart()
    
        workoutTableView.register(UINib(nibName: CellIdentifiers.sessionHeader, bundle: nil), forCellReuseIdentifier: CellIdentifiers.sessionHeader)
        workoutTableView.register(UINib(nibName: CellIdentifiers.exorcise, bundle: nil), forCellReuseIdentifier: CellIdentifiers.exorcise)
    }
    
    fileprivate func updateSessions() {
        guard   let user = UserProvider().user(named: userName),
                let exorciseName = self.exorciseName else {
            return
        }
        sessions = sessionProvider.getLastSessions(numberOfSessions: nil, for: user, performing: exorciseName)
    }
}

extension MainHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == userTableView {
            return 0
        } else if tableView == workoutTableView {
            return 50
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        if tableView == workoutTableView {
            let headerCell = workoutTableView.dequeueReusableCell(withIdentifier: CellIdentifiers.sessionHeader) as! HistoryTableViewHeader
            headerCell.frame.size = CGSize(width: tableView.frame.width, height: 50)
            let dateString = DateFormatterUtil().string(for: sessions[section].date)
            headerCell.sessionLabel.text = "\(dateString ?? "")"
            headerView.addSubview(headerCell)
        }
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == userTableView {
            return 1
        } else if tableView == workoutTableView {
            return sessions.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == userTableView {
            return users.count
        } else if tableView == workoutTableView {
            let exorcise = ExorciseProvider().exorcise(named: exorciseName ?? "", in: sessions[section])
            return exorcise?.consistsOf?.count ?? 0
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == userTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.user, for: indexPath) as! HistoryUserTableViewCell
            cell.nameLabel.text = users[indexPath.row].name
            return cell
        } else if tableView == workoutTableView {
            let exorcise = ExorciseProvider().exorcise(named: exorciseName ?? "", in: sessions[indexPath.section])
            let take = (exorcise?.consistsOf?.array as? [Take])?[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.exorcise, for: indexPath) as! AddWorkoutTableViewCell
            cell.repsBigLabel.text = "\(take!.repsNumber)"
            cell.weightBigLabel.text = "\(take!.weight)"
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == userTableView {
            userName = users[indexPath.row].name!
            updateSessions()
            updateChart()
            UIView.animate(withDuration: 10, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.userTableViewHeightConstraint.constant = 0
            }, completion: nil)
        }
    }

}

extension MainHistoryViewController {
    
    fileprivate func updateChart() {
        var values = [Double]()

        for session in sessions.reversed() {
            let exorcise = ExorciseProvider().exorcise(named: exorciseName ?? "", in: session)
            guard let takes = (exorcise?.consistsOf?.array as? [Take]) else {
                continue
            }
            let newYVal = takes.reduce(0) { res, take in
                return res + Double(take.repsNumber) * Double(take.weight)
            }
            values.append(newYVal)
        }
        setChart(values: values)
        
    }

    fileprivate func setChart(values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        
        for (index, value) in values.enumerated() {
            dataEntries.append(ChartDataEntry(x: Double(index), y: value))
        }
        
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "Workouts")
        lineChartDataSet.axisDependency = .right
        lineChartDataSet.circleRadius = 0
        chartView.chartDescription?.enabled = false
        chartView.leftAxis.axisMinimum = 0.0
        chartView.xAxis.labelTextColor = .white
        chartView.leftAxis.labelTextColor = .white
        chartView.rightAxis.labelTextColor = .white
        chartView.legend.enabled = false
        chartView.data = LineChartData(dataSet: lineChartDataSet)
    }
    
}
