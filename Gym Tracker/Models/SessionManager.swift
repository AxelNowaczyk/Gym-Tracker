//
//  SessionManager.swift
//  Gym Tracker
//
//  Created by Axel Nowaczyk on 04/03/2017.
//  Copyright © 2017 Axel Nowaczyk. All rights reserved.
//

import Foundation

class SessionManager: NSObject {
    
    fileprivate(set) var currentSession: Session!
    fileprivate(set) var previousSession: Session?
    fileprivate let sessionProvider = SessionProvider()
    
    init(user: User, exorciseName: String) {
        super.init()
        
        let lastSessions = sessionProvider.getLastSessions(numberOfSessions: 2, for: user, performing: exorciseName)
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
                currentSession = sessionProvider.storeSession(for: user)
                previousSession = storedSession
            }
        case 1:
            let storedSession = sessions[0]
            if NSCalendar.current.isDateInToday(storedSession.date! as Date) {
                currentSession = storedSession
            } else {
                currentSession = sessionProvider.storeSession(for: user)
                previousSession = storedSession
            }
        case 0:
            currentSession = sessionProvider.storeSession(for: user)
        default: break
        }
        
    }
    
}
