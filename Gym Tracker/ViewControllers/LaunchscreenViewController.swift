//
//  LaunchscreenViewController.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 15/01/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import Foundation
import UIKit

class LaunchscreenViewController: UIViewController {
 
    @IBOutlet var dumbbellImageView: UIImageView!
    
    let debug = true
    
    final let userProbability = 90
    final let exorciseProbability = 80

    fileprivate enum UserNameType: String {
        case axel   = "Axel"
        case maciek = "Maciek"
    }
    
    fileprivate enum ExorciseNameType: String {
        case lawkaSkosnaDol   = "Lawka Skosna Dol"
        case lawkaSkosnaGora = "Lawka Skosna Gora"
        case pushUps = "Push Ups"
        case dips   = "Dips"
        
        case hantle = "Hantle"
        case barki = "Barki"
        case bicek = "Bicek"
        case pullUps   = "Pull Ups"

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        performInitialSetup()
    }
    
    private var dataWasFetched = false
    func performInitialSetup() {
        DispatchQueue.global().async {
            ExorciseProvider().removeExorcisesWithNoTakes {
                self.performInitialSetup {
                    self.dataWasFetched = true
                }
            }
        }
        performAnimation {
            if self.dataWasFetched {
                let viewController = UIStoryboard(name: "MainTabBar", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as? MainTabBarController
                UIApplication.shared.keyWindow?.rootViewController = viewController
                self.performSegue(withIdentifier: "Show tabbarController", sender: self)
            } else {
                self.performInitialSetup()
            }
        }
    }
    
    func performAnimation(completionHandler: @escaping (Void) -> Void) {
        UIView.animate(withDuration: 2.0, animations: {
            self.dumbbellImageView.transform = CGAffineTransform(rotationAngle: .pi)
            self.view.layoutIfNeeded()
        }) { _ in
            UIView.animate(withDuration: 2.0, animations: {
                self.dumbbellImageView.transform = CGAffineTransform(rotationAngle: 0)
                self.view.layoutIfNeeded()
            }) { _ in
                completionHandler()
            }
        }
    }
    
    func performInitialSetup(completionHandler: () -> Void) {
        if debug {
            performInitialSetupForDebug {
                completionHandler()
            }
        } else {
            completionHandler()
        }
    }
    func performInitialSetupForDebug(completionHandler: () -> Void) {
        
        if UserProvider().users.isEmpty {
            setupWorkouts()
        }
        
        completionHandler()
    }
    
    private func setupWorkouts() {
        let userProvider = UserProvider()
        let sessionProvider = SessionProvider()
        let axelUser = userProvider.storeUser(named: UserNameType.axel.rawValue)
        let maciekUser = userProvider.storeUser(named: UserNameType.maciek.rawValue)
        
        var date: Date!
        var sessionA: Session!
        var sessionM: Session!
        // Day 1
        date = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        sessionA = sessionProvider.storeSession(for: axelUser, with: date)
        sessionM = sessionProvider.storeSession(for: maciekUser, with: date)
        setupWorkout(named: ExorciseNameType.lawkaSkosnaDol.rawValue, in: sessionA, repNumber: 10, weight: 70)
        setupWorkout(named: ExorciseNameType.lawkaSkosnaDol.rawValue, in: sessionM, repNumber: 10, weight: 50)
        setupWorkout(named: ExorciseNameType.lawkaSkosnaGora.rawValue, in: sessionA, repNumber: 10, weight: 60)
        setupWorkout(named: ExorciseNameType.lawkaSkosnaGora.rawValue, in: sessionM, repNumber: 10, weight: 45)
        setupWorkout(named: ExorciseNameType.pushUps.rawValue, in: sessionA, repNumber: 10, weight: 0)
        setupWorkout(named: ExorciseNameType.pushUps.rawValue, in: sessionM, repNumber: 10, weight: 0)
        setupWorkout(named: ExorciseNameType.dips.rawValue, in: sessionA, repNumber: 10, weight: 10)
        setupWorkout(named: ExorciseNameType.dips.rawValue, in: sessionM, repNumber: 10, weight: -10)
        // Day 2
        date = Calendar.current.date(byAdding: .day, value: -6, to: Date())
        sessionA = sessionProvider.storeSession(for: axelUser, with: date)
        sessionM = sessionProvider.storeSession(for: maciekUser, with: date)
        setupWorkout(named: ExorciseNameType.hantle.rawValue, in: sessionA, repNumber: 10, weight: 65)
        setupWorkout(named: ExorciseNameType.hantle.rawValue, in: sessionM, repNumber: 10, weight: 30)
        setupWorkout(named: ExorciseNameType.barki.rawValue, in: sessionA, repNumber: 10, weight: 25)
        setupWorkout(named: ExorciseNameType.barki.rawValue, in: sessionM, repNumber: 10, weight: 15)
        setupWorkout(named: ExorciseNameType.bicek.rawValue, in: sessionA, repNumber: 10, weight: 25)
        setupWorkout(named: ExorciseNameType.bicek.rawValue, in: sessionM, repNumber: 10, weight: 20)
        setupWorkout(named: ExorciseNameType.pullUps.rawValue, in: sessionA, repNumber: 10, weight: -10)
        setupWorkout(named: ExorciseNameType.pullUps.rawValue, in: sessionM, repNumber: 10, weight: -30)
        // Day 3
        date = Calendar.current.date(byAdding: .day, value: -5, to: Date())
        sessionA = sessionProvider.storeSession(for: axelUser, with: date)
        sessionM = sessionProvider.storeSession(for: maciekUser, with: date)
        setupWorkout(named: ExorciseNameType.lawkaSkosnaDol.rawValue, in: sessionA, repNumber: 10, weight: 71)
        setupWorkout(named: ExorciseNameType.lawkaSkosnaDol.rawValue, in: sessionM, repNumber: 10, weight: 51)
        setupWorkout(named: ExorciseNameType.lawkaSkosnaGora.rawValue, in: sessionA, repNumber: 10, weight: 61)
        setupWorkout(named: ExorciseNameType.lawkaSkosnaGora.rawValue, in: sessionM, repNumber: 10, weight: 46)
        setupWorkout(named: ExorciseNameType.pushUps.rawValue, in: sessionA, repNumber: 10, weight: 1)
        setupWorkout(named: ExorciseNameType.pushUps.rawValue, in: sessionM, repNumber: 10, weight: 1)
        setupWorkout(named: ExorciseNameType.dips.rawValue, in: sessionA, repNumber: 10, weight: 11)
        setupWorkout(named: ExorciseNameType.dips.rawValue, in: sessionM, repNumber: 10, weight: -9)
        // Day 4
        date = Calendar.current.date(byAdding: .day, value: -4, to: Date())
        sessionA = sessionProvider.storeSession(for: axelUser, with: date)
        sessionM = sessionProvider.storeSession(for: maciekUser, with: date)
        setupWorkout(named: ExorciseNameType.hantle.rawValue, in: sessionA, repNumber: 10, weight: 66)
        setupWorkout(named: ExorciseNameType.barki.rawValue, in: sessionA, repNumber: 10, weight: 26)
        setupWorkout(named: ExorciseNameType.bicek.rawValue, in: sessionA, repNumber: 10, weight: 26)
        setupWorkout(named: ExorciseNameType.pullUps.rawValue, in: sessionA, repNumber: 10, weight: -9)
        // Day 5
        date = Calendar.current.date(byAdding: .day, value: -3, to: Date())
        sessionA = sessionProvider.storeSession(for: axelUser, with: date)
        sessionM = sessionProvider.storeSession(for: maciekUser, with: date)
        setupWorkout(named: ExorciseNameType.lawkaSkosnaDol.rawValue, in: sessionA, repNumber: 10, weight: 72)
        setupWorkout(named: ExorciseNameType.lawkaSkosnaDol.rawValue, in: sessionM, repNumber: 10, weight: 52)
        setupWorkout(named: ExorciseNameType.lawkaSkosnaGora.rawValue, in: sessionA, repNumber: 10, weight: 62)
        setupWorkout(named: ExorciseNameType.lawkaSkosnaGora.rawValue, in: sessionM, repNumber: 10, weight: 47)
        setupWorkout(named: ExorciseNameType.pushUps.rawValue, in: sessionA, repNumber: 10, weight: 2)
        setupWorkout(named: ExorciseNameType.pushUps.rawValue, in: sessionM, repNumber: 10, weight: 2)
        setupWorkout(named: ExorciseNameType.dips.rawValue, in: sessionA, repNumber: 10, weight: 12)
        setupWorkout(named: ExorciseNameType.dips.rawValue, in: sessionM, repNumber: 10, weight: -8)
        // Day 6
        date = Calendar.current.date(byAdding: .day, value: -2, to: Date())
        sessionA = sessionProvider.storeSession(for: axelUser, with: date)
        sessionM = sessionProvider.storeSession(for: maciekUser, with: date)
        setupWorkout(named: ExorciseNameType.hantle.rawValue, in: sessionA, repNumber: 10, weight: 68)
        setupWorkout(named: ExorciseNameType.hantle.rawValue, in: sessionM, repNumber: 10, weight: 33)
        setupWorkout(named: ExorciseNameType.barki.rawValue, in: sessionA, repNumber: 10, weight: 28)
        setupWorkout(named: ExorciseNameType.barki.rawValue, in: sessionM, repNumber: 10, weight: 18)
        setupWorkout(named: ExorciseNameType.bicek.rawValue, in: sessionA, repNumber: 10, weight: 28)
        setupWorkout(named: ExorciseNameType.bicek.rawValue, in: sessionM, repNumber: 10, weight: 23)
        setupWorkout(named: ExorciseNameType.pullUps.rawValue, in: sessionA, repNumber: 10, weight: -7)
        setupWorkout(named: ExorciseNameType.pullUps.rawValue, in: sessionM, repNumber: 10, weight: -27)
        // Day 7
        date = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        sessionA = sessionProvider.storeSession(for: axelUser, with: date)
        sessionM = sessionProvider.storeSession(for: maciekUser, with: date)
        setupWorkout(named: ExorciseNameType.lawkaSkosnaDol.rawValue, in: sessionA, repNumber: 10, weight: 74)
        setupWorkout(named: ExorciseNameType.lawkaSkosnaDol.rawValue, in: sessionM, repNumber: 10, weight: 54)
        setupWorkout(named: ExorciseNameType.lawkaSkosnaGora.rawValue, in: sessionA, repNumber: 10, weight: 64)
        setupWorkout(named: ExorciseNameType.lawkaSkosnaGora.rawValue, in: sessionM, repNumber: 10, weight: 49)
        setupWorkout(named: ExorciseNameType.pushUps.rawValue, in: sessionA, repNumber: 10, weight: 4)
        setupWorkout(named: ExorciseNameType.pushUps.rawValue, in: sessionM, repNumber: 10, weight: 4)
        setupWorkout(named: ExorciseNameType.dips.rawValue, in: sessionA, repNumber: 10, weight: 14)
        setupWorkout(named: ExorciseNameType.dips.rawValue, in: sessionM, repNumber: 10, weight: -6)
        userProvider.saveContext()
    }
    
    private func setupWorkout(named workoutName: String, in session: Session, repNumber: Int = 0, weight: Double = 0) {
        let workout = ExorciseProvider().storeExorcise(named: workoutName, in: session)
        let takeProvider = TakeProvider()
        for i in 0..<3 {
            _ = takeProvider.storeTake(repsNumber: repNumber+i, weight: weight, for: workout)
        }
    }

}








