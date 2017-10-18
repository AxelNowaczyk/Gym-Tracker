//
//  SessionManager.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 04/03/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import Foundation

class SessionManager: NSObject {
    
    private(set) var currentSession: Session!
    private(set) var previousSession: Session?
    private let sessionProvider = SessionProvider()
    
    init(user: User, exerciseName: String) {
        super.init()
        
        let lastSessions = SessionProvider.getLastSessions(numberOfSessions: 2, for: user, performing: exerciseName)
        initSessions(sessions: lastSessions, for: user)
    }
    
    private func initSessions(sessions: [Session], for user: User) {
        
        switch sessions.count {
        case 2:
            let storedSession = sessions[0]
            if NSCalendar.current.isDateInToday(storedSession.date! as Date) {
                currentSession = storedSession
                previousSession = sessions[1]
            } else {
                currentSession = SessionProvider.storeSession(for: user)
                previousSession = storedSession
            }
        case 1:
            let storedSession = sessions[0]
            if NSCalendar.current.isDateInToday(storedSession.date! as Date) {
                currentSession = storedSession
            } else {
                currentSession = SessionProvider.storeSession(for: user)
                previousSession = storedSession
            }
        case 0:
            currentSession = SessionProvider.storeSession(for: user)
        default: break
        }
        
    }
    
}
