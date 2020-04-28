//
// Created by YILDIRIM ADIGÜZEL on 24.04.2020.
// Copyright (c) 2020 xennio. All rights reserved.
//

import XCTest

class NotificationProcessorHandlerTest: XCTestCase {

    func test_it_should_construct_save_push_token_event_and_make_api_call() {
        let sessionContextHolder = FakeSessionContextHolder()
        let applicationContextHolder = FakeApplicationContextHolder(userDefaults: InitializedUserDefaults(), sdkKey: "SDK-KEY")

        let httpService = FakeHttpService(collectorUrl: "collector-url", session: FakeUrlSession())
        let entitySerializerService = CapturingEntitySerializerService.init()
        let notificationProcessorHandler = NotificationProcessorHandler(applicationContextHolder: applicationContextHolder, sessionContextHolder: sessionContextHolder, httpService: httpService, entitySerializerService: entitySerializerService)
        entitySerializerService.givenSerializeReturns(callWith: TestUtils.anyDictionary(), expect: "serialized_event")
        httpService.givenPostWithPayload(callWith: "serialized_event")

        notificationProcessorHandler.savePushToken(deviceToken: "token")

        let captured = entitySerializerService.getCapturedEvent()

        XCTAssertFalse(httpService.hasError)

        let header = captured["h"] as! Dictionary<String, Any>
        let body = captured["b"] as! Dictionary<String, Any>

        XCTAssertTrue("Collection" == header["n"] as! String)
        XCTAssertTrue(applicationContextHolder.getPersistentId() == header["p"] as! String)
        XCTAssertTrue(sessionContextHolder.getSessionId() == header["s"] as! String)
        XCTAssertTrue(sessionContextHolder.getMemberId() == body["memberId"] as! String)
        XCTAssertTrue("token" == body["deviceToken"] as! String)
        XCTAssertTrue("iosToken" == body["type"] as! String)
        XCTAssertTrue("iosAppPush" == body["appType"] as! String)
        XCTAssertTrue("pushToken" == body["name"] as! String)

    }

    func test_it_should_construct_push_receive_event_and_make_api_call() {
        let sessionContextHolder = FakeSessionContextHolder().withExtraParameters(["utm_source": "xennio"])
        let applicationContextHolder = FakeApplicationContextHolder(userDefaults: InitializedUserDefaults(), sdkKey: "SDK-KEY")

        let httpService = FakeHttpService(collectorUrl: "collector-url", session: FakeUrlSession())
        let entitySerializerService = CapturingEntitySerializerService.init()
        let notificationProcessorHandler = NotificationProcessorHandler(applicationContextHolder: applicationContextHolder, sessionContextHolder: sessionContextHolder, httpService: httpService, entitySerializerService: entitySerializerService)
        entitySerializerService.givenSerializeReturns(callWith: TestUtils.anyDictionary(), expect: "serialized_event")
        httpService.givenPostWithPayload(callWith: "serialized_event")

        notificationProcessorHandler.pushMessageReceived()

        let captured = entitySerializerService.getCapturedEvent()

        XCTAssertFalse(httpService.hasError)

        let header = captured["h"] as! Dictionary<String, Any>
        let body = captured["b"] as! Dictionary<String, Any>

        XCTAssertTrue("Feedback" == header["n"] as! String)
        XCTAssertTrue(applicationContextHolder.getPersistentId() == header["p"] as! String)
        XCTAssertTrue(sessionContextHolder.getSessionId() == header["s"] as! String)
        XCTAssertTrue(sessionContextHolder.getMemberId() == body["memberId"] as! String)
        XCTAssertTrue("pushReceived" == body["type"] as! String)
        XCTAssertTrue("xennio" == body["utm_source"] as! String)

    }

    func test_it_should_construct_push_opened_event_and_make_api_call() {
        let sessionContextHolder = FakeSessionContextHolder().withExtraParameters(["utm_source": "xennio"])
        let applicationContextHolder = FakeApplicationContextHolder(userDefaults: InitializedUserDefaults(), sdkKey: "SDK-KEY")

        let httpService = FakeHttpService(collectorUrl: "collector-url", session: FakeUrlSession())
        let entitySerializerService = CapturingEntitySerializerService.init()
        let notificationProcessorHandler = NotificationProcessorHandler(applicationContextHolder: applicationContextHolder, sessionContextHolder: sessionContextHolder, httpService: httpService, entitySerializerService: entitySerializerService)
        entitySerializerService.givenSerializeReturns(callWith: TestUtils.anyDictionary(), expect: "serialized_event")
        httpService.givenPostWithPayload(callWith: "serialized_event")

        notificationProcessorHandler.pushMessageOpened()

        let captured = entitySerializerService.getCapturedEvent()

        XCTAssertFalse(httpService.hasError)

        let header = captured["h"] as! Dictionary<String, Any>
        let body = captured["b"] as! Dictionary<String, Any>

        XCTAssertTrue("Feedback" == header["n"] as! String)
        XCTAssertTrue(applicationContextHolder.getPersistentId() == header["p"] as! String)
        XCTAssertTrue(sessionContextHolder.getSessionId() == header["s"] as! String)
        XCTAssertTrue(sessionContextHolder.getMemberId() == body["memberId"] as! String)
        XCTAssertTrue("pushOpened" == body["type"] as! String)
        XCTAssertTrue("xennio" == body["utm_source"] as! String)
    }
}