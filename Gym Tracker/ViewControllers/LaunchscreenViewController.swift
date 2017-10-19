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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        performInitialSetup()
    }

    private func performInitialSetup() {
        let animator = Animator(superView: self.view, using: dumbbellImageView)
        animator.startAnimation()

        DispatchQueue.global().async {
            ExerciseProvider.removeExercisesWithNoTakes {
                let debugDataLoader = DebugDataLoader()
                debugDataLoader.performInitialSetup {
                    DispatchQueue.main.async {
                        animator.stopAnimiation()
                        let viewController = UIStoryboard(name: "MainTabBar", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as? MainTabBarController
                        UIApplication.shared.keyWindow?.rootViewController = viewController
                        self.performSegue(withIdentifier: "Show tabbarController", sender: self)
                    }
                }
            }
        }
    }
}

struct Animator {

    private let superView: UIView
    private let imageView: UIImageView
    private let animation = CABasicAnimation(keyPath: "transform.rotation.z")

    init(superView: UIView, using imageView:UIImageView) {
        self.superView = superView
        self.imageView = imageView
    }

    typealias CompletionHandler = () -> Void
    func startAnimation(completionHandler: CompletionHandler? = nil) {
        imageView.layer.removeAllAnimations()
        animation.fromValue = 0
        animation.toValue =  Double.pi * 2
        animation.duration = 0.5
        animation.repeatCount = .greatestFiniteMagnitude
        imageView.layer.add(animation, forKey: "rotationAnimation")
        completionHandler?()
    }
    func stopAnimiation(completionHandler: CompletionHandler? = nil) {
        imageView.layer.removeAllAnimations()
        completionHandler?()
    }
}

struct DebugDataLoader {

    let debug: Bool

    init(debug: Bool = true) {
        self.debug = debug
    }

    fileprivate enum UserNameType: String {
        case axel   = "Axel"
        case maciek = "Maciek"
    }

    fileprivate enum exerciseNameType: String {
        case lawkaSkosnaDol   = "Decline DB Press"
        case lawkaSkosnaGora = "Incline DB Press"
        case pushUps = "Push Ups"
        case dips   = "Dips"

        case hantle = "DB Flyes"
        case barki = "Machine Press"
        case przysiad = "Front Squat"
        case pullUps   = "Pull Ups"

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

        if UserProvider.users.isEmpty {
            setupWorkouts()
        }

        completionHandler()
    }

    private func setupWorkouts() {
        let axelUser = UserProvider.storeUser(named: UserNameType.axel.rawValue)
        let maciekUser = UserProvider.storeUser(named: UserNameType.maciek.rawValue)

        var date: Date!
        var sessionA: Session!
        var sessionM: Session!
        // Day 1
        date = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        sessionA = SessionProvider.storeSession(for: axelUser, with: date)
        sessionM = SessionProvider.storeSession(for: maciekUser, with: date)
        setupWorkout(named: exerciseNameType.lawkaSkosnaDol.rawValue, in: sessionA, repNumber: 10, weight: 70)
        setupWorkout(named: exerciseNameType.lawkaSkosnaDol.rawValue, in: sessionM, repNumber: 10, weight: 50)
        setupWorkout(named: exerciseNameType.lawkaSkosnaGora.rawValue, in: sessionA, repNumber: 10, weight: 60)
        setupWorkout(named: exerciseNameType.lawkaSkosnaGora.rawValue, in: sessionM, repNumber: 10, weight: 45)
        setupWorkout(named: exerciseNameType.pushUps.rawValue, in: sessionA, repNumber: 10, weight: 0)
        setupWorkout(named: exerciseNameType.pushUps.rawValue, in: sessionM, repNumber: 10, weight: 0)
        setupWorkout(named: exerciseNameType.dips.rawValue, in: sessionA, repNumber: 10, weight: 10)
        setupWorkout(named: exerciseNameType.dips.rawValue, in: sessionM, repNumber: 10, weight: -10)
        // Day 2
        date = Calendar.current.date(byAdding: .day, value: -6, to: Date())
        sessionA = SessionProvider.storeSession(for: axelUser, with: date)
        sessionM = SessionProvider.storeSession(for: maciekUser, with: date)
        setupWorkout(named: exerciseNameType.hantle.rawValue, in: sessionA, repNumber: 10, weight: 65)
        setupWorkout(named: exerciseNameType.hantle.rawValue, in: sessionM, repNumber: 10, weight: 30)
        setupWorkout(named: exerciseNameType.barki.rawValue, in: sessionA, repNumber: 10, weight: 25)
        setupWorkout(named: exerciseNameType.barki.rawValue, in: sessionM, repNumber: 10, weight: 15)
        setupWorkout(named: exerciseNameType.przysiad.rawValue, in: sessionA, repNumber: 10, weight: 25)
        setupWorkout(named: exerciseNameType.przysiad.rawValue, in: sessionM, repNumber: 10, weight: 20)
        setupWorkout(named: exerciseNameType.pullUps.rawValue, in: sessionA, repNumber: 10, weight: -10)
        setupWorkout(named: exerciseNameType.pullUps.rawValue, in: sessionM, repNumber: 10, weight: -30)
        // Day 3
        date = Calendar.current.date(byAdding: .day, value: -5, to: Date())
        sessionA = SessionProvider.storeSession(for: axelUser, with: date)
        sessionM = SessionProvider.storeSession(for: maciekUser, with: date)
        setupWorkout(named: exerciseNameType.lawkaSkosnaDol.rawValue, in: sessionA, repNumber: 10, weight: 71)
        setupWorkout(named: exerciseNameType.lawkaSkosnaDol.rawValue, in: sessionM, repNumber: 10, weight: 51)
        setupWorkout(named: exerciseNameType.lawkaSkosnaGora.rawValue, in: sessionA, repNumber: 10, weight: 61)
        setupWorkout(named: exerciseNameType.lawkaSkosnaGora.rawValue, in: sessionM, repNumber: 10, weight: 46)
        setupWorkout(named: exerciseNameType.pushUps.rawValue, in: sessionA, repNumber: 10, weight: 1)
        setupWorkout(named: exerciseNameType.pushUps.rawValue, in: sessionM, repNumber: 10, weight: 1)
        setupWorkout(named: exerciseNameType.dips.rawValue, in: sessionA, repNumber: 10, weight: 11)
        setupWorkout(named: exerciseNameType.dips.rawValue, in: sessionM, repNumber: 10, weight: -9)
        // Day 4
        date = Calendar.current.date(byAdding: .day, value: -4, to: Date())
        sessionA = SessionProvider.storeSession(for: axelUser, with: date)
        sessionM = SessionProvider.storeSession(for: maciekUser, with: date)
        setupWorkout(named: exerciseNameType.hantle.rawValue, in: sessionA, repNumber: 10, weight: 66)
        setupWorkout(named: exerciseNameType.barki.rawValue, in: sessionA, repNumber: 10, weight: 26)
        setupWorkout(named: exerciseNameType.przysiad.rawValue, in: sessionA, repNumber: 10, weight: 26)
        setupWorkout(named: exerciseNameType.pullUps.rawValue, in: sessionA, repNumber: 10, weight: -9)
        // Day 5
        date = Calendar.current.date(byAdding: .day, value: -3, to: Date())
        sessionA = SessionProvider.storeSession(for: axelUser, with: date)
        sessionM = SessionProvider.storeSession(for: maciekUser, with: date)
        setupWorkout(named: exerciseNameType.lawkaSkosnaDol.rawValue, in: sessionA, repNumber: 10, weight: 72)
        setupWorkout(named: exerciseNameType.lawkaSkosnaDol.rawValue, in: sessionM, repNumber: 10, weight: 52)
        setupWorkout(named: exerciseNameType.lawkaSkosnaGora.rawValue, in: sessionA, repNumber: 10, weight: 62)
        setupWorkout(named: exerciseNameType.lawkaSkosnaGora.rawValue, in: sessionM, repNumber: 10, weight: 47)
        setupWorkout(named: exerciseNameType.pushUps.rawValue, in: sessionA, repNumber: 10, weight: 2)
        setupWorkout(named: exerciseNameType.pushUps.rawValue, in: sessionM, repNumber: 10, weight: 2)
        setupWorkout(named: exerciseNameType.dips.rawValue, in: sessionA, repNumber: 10, weight: 12)
        setupWorkout(named: exerciseNameType.dips.rawValue, in: sessionM, repNumber: 10, weight: -8)
        // Day 6
        date = Calendar.current.date(byAdding: .day, value: -2, to: Date())
        sessionA = SessionProvider.storeSession(for: axelUser, with: date)
        sessionM = SessionProvider.storeSession(for: maciekUser, with: date)
        setupWorkout(named: exerciseNameType.hantle.rawValue, in: sessionA, repNumber: 10, weight: 68)
        setupWorkout(named: exerciseNameType.hantle.rawValue, in: sessionM, repNumber: 10, weight: 33)
        setupWorkout(named: exerciseNameType.barki.rawValue, in: sessionA, repNumber: 10, weight: 28)
        setupWorkout(named: exerciseNameType.barki.rawValue, in: sessionM, repNumber: 10, weight: 18)
        setupWorkout(named: exerciseNameType.przysiad.rawValue, in: sessionA, repNumber: 10, weight: 28)
        setupWorkout(named: exerciseNameType.przysiad.rawValue, in: sessionM, repNumber: 10, weight: 23)
        setupWorkout(named: exerciseNameType.pullUps.rawValue, in: sessionA, repNumber: 10, weight: -7)
        setupWorkout(named: exerciseNameType.pullUps.rawValue, in: sessionM, repNumber: 10, weight: -27)
        // Day 7
        date = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        sessionA = SessionProvider.storeSession(for: axelUser, with: date)
        sessionM = SessionProvider.storeSession(for: maciekUser, with: date)
        setupWorkout(named: exerciseNameType.lawkaSkosnaDol.rawValue, in: sessionA, repNumber: 10, weight: 74)
        setupWorkout(named: exerciseNameType.lawkaSkosnaDol.rawValue, in: sessionM, repNumber: 10, weight: 54)
        setupWorkout(named: exerciseNameType.lawkaSkosnaGora.rawValue, in: sessionA, repNumber: 10, weight: 64)
        setupWorkout(named: exerciseNameType.lawkaSkosnaGora.rawValue, in: sessionM, repNumber: 10, weight: 49)
        setupWorkout(named: exerciseNameType.pushUps.rawValue, in: sessionA, repNumber: 10, weight: 4)
        setupWorkout(named: exerciseNameType.pushUps.rawValue, in: sessionM, repNumber: 10, weight: 4)
        setupWorkout(named: exerciseNameType.dips.rawValue, in: sessionA, repNumber: 10, weight: 14)
        setupWorkout(named: exerciseNameType.dips.rawValue, in: sessionM, repNumber: 10, weight: -6)
        CoreDataStack.shared.save()
    }

    private func setupWorkout(named workoutName: String, in session: Session, repNumber: Int = 0, weight: Double = 0) {
        let workout = ExerciseProvider.storeExercise(named: workoutName, in: session)
        for i in 0..<3 {
            _ = TakeProvider.storeTake(repsNumber: repNumber+i, weight: weight, for: workout)
        }
    }
}






