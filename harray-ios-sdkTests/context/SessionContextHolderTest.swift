//
//  SessionContextHolderTest.swift
//  harray-ios-sdkTests
//
//  Created by YILDIRIM ADIGÜZEL on 21.04.2020.
//  Copyright © 2020 xennio. All rights reserved.
//

import XCTest

class SessionContextHolderTest: XCTestCase {

    func test_it_should_initialize_session_id_and_session_start_time() {
        ClockUtils.freeze()
        RandomValueUtils.freeze()
        let sessionStartTime = ClockUtils.getTime()
        let sessionId = RandomValueUtils.randomUUID()

        let sessionContextHolder = SessionContextHolder()

        XCTAssertEqual(sessionId, sessionContextHolder.getSessionId())
        XCTAssertTrue(sessionStartTime == sessionContextHolder.getSessionStartTime())
        XCTAssertTrue(sessionStartTime == sessionContextHolder.getLastActivityTime())
        XCTAssertTrue(sessionContextHolder.getExternalParameters().isEmpty)

        XCTAssertEqual(SessionState.SESSION_INITIALIZED, sessionContextHolder.getSessionState())

        ClockUtils.unFreeze()
        RandomValueUtils.unFreeze()
    }

    func test_it_should_get_session_id_and_extend_session_time() {
        let expectedTime: Int64 = 1587133370000
        ClockUtils.freeze(expectedTime: expectedTime)
        RandomValueUtils.freeze()
        let sessionId = RandomValueUtils.randomUUID()
        let sessionContextHolder = SessionContextHolder()
        let resolvedSessionId = sessionContextHolder.getSessionIdAndExtendSession();
        let lastActivityTime = sessionContextHolder.getLastActivityTime();

        XCTAssertEqual(sessionId, resolvedSessionId)
        XCTAssertEqual(lastActivityTime, expectedTime)
        ClockUtils.unFreeze()
        RandomValueUtils.unFreeze()
    }

    func test_it_should_get_create_new_session_id_when_session_expired() {
        let expectedTime: Int64 = 1587133370000
        ClockUtils.freeze(expectedTime: expectedTime)
        RandomValueUtils.freeze()
        let sessionContextHolder = SessionContextHolder()
        let resolvedSessionId = sessionContextHolder.getSessionIdAndExtendSession()
        RandomValueUtils.unFreeze();

        let expectedTimeInFuture: Int64 = expectedTime + 60 * 60 * 1000
        ClockUtils.freeze(expectedTime: expectedTimeInFuture)
        let resolvedSessionId2 = sessionContextHolder.getSessionIdAndExtendSession()
        let lastActivityTime = sessionContextHolder.getLastActivityTime()
        let sessionStartTime = sessionContextHolder.getSessionStartTime()

        XCTAssertNotEqual(resolvedSessionId, resolvedSessionId2)
        XCTAssertTrue(lastActivityTime == expectedTimeInFuture)
        XCTAssertTrue(sessionStartTime == expectedTimeInFuture)
        XCTAssertTrue(sessionContextHolder.getExternalParameters().isEmpty)
        XCTAssertEqual(SessionState.SESSION_RESTARTED, sessionContextHolder.getSessionState())
        ClockUtils.unFreeze();
    }

    func test_it_should_log_in_member() {
        let sessionContextHolder = SessionContextHolder()
        let memberId = "memberId";
        sessionContextHolder.login(memberId: memberId)
        XCTAssertEqual(memberId, sessionContextHolder.getMemberId())
    }

    func test_it_should_log_out_member() {
        let sessionContextHolder = SessionContextHolder()
        let memberId = "memberId";
        sessionContextHolder.login(memberId: memberId)
        XCTAssertEqual(memberId, sessionContextHolder.getMemberId())
        sessionContextHolder.logout()
        XCTAssertNil(sessionContextHolder.getMemberId())
    }

    func test_it_should_change_session_state_when_session_started() {
        let sessionContextHolder = SessionContextHolder()
        sessionContextHolder.startSession()
        XCTAssertEqual(SessionState.SESSION_STARTED, sessionContextHolder.getSessionState())
    }

    func test_it_should_update_external_parameters() {
        let sessionContextHolder = SessionContextHolder()
        let externalParameters: Dictionary<String, Any> = [
            "a": "b",
            "c": "e",
            "d": "f",
            "campaignId": "campaignId",
            "campaignDate": "campaignDate",
            "pushId": "pushId",
            "url": "url",
            "utm_source": "utm_source",
            "utm_medium": "utm_medium",
            "utm_campaign": "utm_campaign",
            "utm_term": "utm_term",
            "utm_content": "utm_content"
        ]
        sessionContextHolder.updateExternalParameters(data: externalParameters)
        let boundedExternalParameters = sessionContextHolder.getExternalParameters()
        XCTAssertNil(boundedExternalParameters["a"])
        XCTAssertNil(boundedExternalParameters["c"])
        XCTAssertNil(boundedExternalParameters["d"])

        XCTAssertTrue("campaignId" == boundedExternalParameters["campaignId"] as! String)
        XCTAssertTrue("campaignDate" == boundedExternalParameters["campaignDate"] as! String)
        XCTAssertTrue("pushId" == boundedExternalParameters["pushId"] as! String)
        XCTAssertTrue("url" == boundedExternalParameters["url"] as! String)
        XCTAssertTrue("utm_source" == boundedExternalParameters["utm_source"] as! String)
        XCTAssertTrue("utm_medium" == boundedExternalParameters["utm_medium"] as! String)
        XCTAssertTrue("utm_campaign" == boundedExternalParameters["utm_campaign"] as! String)
        XCTAssertTrue("utm_term" == boundedExternalParameters["utm_term"] as! String)
        XCTAssertTrue("utm_content" == boundedExternalParameters["utm_content"] as! String)
    }

    func test_it_should_update_external_parameters_when_parameter_present() {
        let sessionContextHolder = SessionContextHolder()
        let externalParameters: Dictionary<String, Any> = [
            "a": "b",
            "campaignId": "campaignId"
        ]
        sessionContextHolder.updateExternalParameters(data: externalParameters)
        let boundedExternalParameters = sessionContextHolder.getExternalParameters()
        XCTAssertNil(boundedExternalParameters["a"])
        XCTAssertNil(boundedExternalParameters["utm_campaign"])
        XCTAssertTrue("campaignId" == boundedExternalParameters["campaignId"] as! String)
    }

    func test_it_should_update_external_parameters_with_any_hashable() {
        let sessionContextHolder = SessionContextHolder()
        let externalParameters: Dictionary<AnyHashable, Any> = [
            "a": "b",
            "c": "e",
            "d": "f",
            "campaignId": "campaignId",
            "campaignDate": "campaignDate",
            "pushId": "pushId",
            "url": "url",
            "utm_source": "utm_source",
            "utm_medium": "utm_medium",
            "utm_campaign": "utm_campaign",
            "utm_term": "utm_term",
            "utm_content": "utm_content",
            1: "asa"

        ]
        sessionContextHolder.updateExternalParameters(data: externalParameters)
        let boundedExternalParameters = sessionContextHolder.getExternalParameters()
        XCTAssertNil(boundedExternalParameters["a"])
        XCTAssertNil(boundedExternalParameters["c"])
        XCTAssertNil(boundedExternalParameters["d"])

        XCTAssertTrue("campaignId" == boundedExternalParameters["campaignId"] as! String)
        XCTAssertTrue("campaignDate" == boundedExternalParameters["campaignDate"] as! String)
        XCTAssertTrue("pushId" == boundedExternalParameters["pushId"] as! String)
        XCTAssertTrue("url" == boundedExternalParameters["url"] as! String)
        XCTAssertTrue("utm_source" == boundedExternalParameters["utm_source"] as! String)
        XCTAssertTrue("utm_medium" == boundedExternalParameters["utm_medium"] as! String)
        XCTAssertTrue("utm_campaign" == boundedExternalParameters["utm_campaign"] as! String)
        XCTAssertTrue("utm_term" == boundedExternalParameters["utm_term"] as! String)
        XCTAssertTrue("utm_content" == boundedExternalParameters["utm_content"] as! String)
    }
    
}
