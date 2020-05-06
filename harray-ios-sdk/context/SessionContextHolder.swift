//
//  SessionContextHolder.swift
//  harray-ios-sdk
//
//  Created by YILDIRIM ADIGÜZEL on 21.04.2020.
//  Copyright © 2020 xennio. All rights reserved.
//

import Foundation

class SessionContextHolder {
    private let sessionDuration: Int = 30 * 60 * 1000
    private var sessionId: String
    private var memberId: String?
    private var sessionStartTime: Int
    private var lastActivityTime: Int
    private var sessionState: SessionState = SessionState.SESSION_INITIALIZED
    private var externalParameters: Dictionary<String, Any> = Dictionary<String, Any>()
    private let externalParameterKeys: Array<String> = ["campaignId", "campaignDate", "pushId", "url", "gclid", "utm_source", "utm_medium", "utm_campaign", "utm_term", "utm_content"]

    init() {
        let now = ClockUtils.getTime()
        self.sessionId = RandomValueUtils.randomUUID()
        self.sessionStartTime = now
        self.lastActivityTime = now
    }

    func getSessionIdAndExtendSession() -> String {
        let now = ClockUtils.getTime()
        if lastActivityTime + sessionDuration < now {
            self.sessionId = RandomValueUtils.randomUUID()
            self.sessionStartTime = now
            self.sessionState = SessionState.SESSION_RESTARTED
            self.externalParameters = Dictionary<String, Any>()
        }
        lastActivityTime = now
        return self.sessionId
    }

    func login(memberId: String) {
        self.memberId = memberId
    }

    func logout() {
        self.memberId = nil
    }

    func startSession() {
        self.sessionState = SessionState.SESSION_STARTED
    }

    func updateExternalParameters(data: Dictionary<String, Any>) {
        for eachItem in self.externalParameterKeys {
            if data[eachItem] != nil {
                self.externalParameters[eachItem] = data[eachItem]
            }
        }
    }

    func updateExternalParameters(data: Dictionary<AnyHashable, Any>) {
        for eachItem in self.externalParameterKeys {
            if data[eachItem] != nil {
                self.externalParameters[eachItem] = data[eachItem]
            }
        }
    }

    func getSessionId() -> String {
        return self.sessionId
    }

    func getSessionStartTime() -> Int {
        return self.sessionStartTime
    }

    func getLastActivityTime() -> Int {
        return self.sessionStartTime
    }

    func getMemberId() -> String? {
        return self.memberId
    }

    func getExternalParameters() -> Dictionary<String, Any> {
        return self.externalParameters
    }

    func getSessionState() -> SessionState {
        return self.sessionState
    }

}
