//
// Created by YILDIRIM ADIGÜZEL on 24.04.2020.
// Copyright (c) 2020 xennio. All rights reserved.
//

import XCTest

class NotificationProcessorHandlerTest: XCTestCase {


    func test_it_should_construct_push_receive_event_and_make_api_call() {
        let httpService = FakeHttpService(sdkKey: "sdk-key", session: FakeUrlSession())
        let entitySerializerService = CapturingEntitySerializerService.init()
        let notificationProcessorHandler = NotificationProcessorHandler(httpService: httpService, entitySerializerService: entitySerializerService)
        entitySerializerService.givenSerializeReturns(callWith: TestUtils.anyDictionary(), expect: "serialized_event")
        httpService.givenPostWithPayload(callWith: "serialized_event")

        notificationProcessorHandler.pushMessageReceived(pushContent: ["pushId": "123123", "campaingId": "campaign"])

        let captured = entitySerializerService.getCapturedEvent()

        XCTAssertFalse(httpService.hasError)

        let header = captured["h"] as! Dictionary<String, Any>
        let body = captured["b"] as! Dictionary<String, Any>

        XCTAssertTrue("Feedback" == header["n"] as! String)
        XCTAssertTrue("pushReceived" == body["type"] as! String)
        XCTAssertTrue("123123" == body["id"] as! String)
    }

    func test_it_should_construct_push_opened_event_and_make_api_call() {
        let httpService = FakeHttpService(sdkKey: "sdk-key", session: FakeUrlSession())
        let entitySerializerService = CapturingEntitySerializerService.init()
        let notificationProcessorHandler = NotificationProcessorHandler(httpService: httpService, entitySerializerService: entitySerializerService)
        entitySerializerService.givenSerializeReturns(callWith: TestUtils.anyDictionary(), expect: "serialized_event")
        httpService.givenPostWithPayload(callWith: "serialized_event")

        notificationProcessorHandler.pushMessageOpened(pushContent: ["pushId": "123123", "campaingId": "campaign"])

        let captured = entitySerializerService.getCapturedEvent()

        XCTAssertFalse(httpService.hasError)

        let header = captured["h"] as! Dictionary<String, Any>
        let body = captured["b"] as! Dictionary<String, Any>

        XCTAssertTrue("Feedback" == header["n"] as! String)
        XCTAssertTrue("pushOpened" == body["type"] as! String)
        XCTAssertTrue("123123" == body["id"] as! String)
    }
}