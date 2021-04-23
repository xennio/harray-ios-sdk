//
// Created by YILDIRIM ADIGÜZEL on 24.04.2020.
// Copyright (c) 2020 xennio. All rights reserved.
//

import XCTest

class NotificationProcessorHandlerTest: XCTestCase {

    func test_it_should_construct_push_receive_event_and_make_api_call() {
        let httpService = FakeHttpService(
            sdkKey: "sdk-key",
            session: FakeUrlSession(),
            collectorUrl: "https://c.xenn.io",
            apiUrl: "https://api.xenn.io"
        )
        let entitySerializerService = CapturingEntitySerializerService.init()
        let notificationProcessorHandler = NotificationProcessorHandler(httpService: httpService, entitySerializerService: entitySerializerService)
        entitySerializerService.givenSerializeReturns(callWith: TestUtils.anyDictionary(), expect: "serialized_event")
        httpService.givenPostWithPayload(callWith: "serialized_event")

        notificationProcessorHandler.pushMessageDelivered(pushContent: ["pushId": "123123", "campaignId": "campaign", "campaignDate": "campaignDate"])

        let captured = entitySerializerService.getCapturedEvent()

        XCTAssertFalse(httpService.hasError)

        XCTAssertTrue("d" == captured["n"] as! String)
        XCTAssertTrue("campaign" == captured["ci"] as! String)
        XCTAssertTrue("123123" == captured["pi"] as! String)
        XCTAssertTrue("campaignDate" == captured["cd"] as! String)
    }

    func test_it_should_construct_push_opened_event_and_make_api_call() {
        let httpService = FakeHttpService(
            sdkKey: "sdk-key",
            session: FakeUrlSession(),
            collectorUrl: "https://c.xenn.io",
            apiUrl: "https://api.xenn.io"
        )
        let entitySerializerService = CapturingEntitySerializerService.init()
        let notificationProcessorHandler = NotificationProcessorHandler(httpService: httpService, entitySerializerService: entitySerializerService)
        entitySerializerService.givenSerializeReturns(callWith: TestUtils.anyDictionary(), expect: "serialized_event")
        httpService.givenPostWithPayload(callWith: "serialized_event")

        notificationProcessorHandler.pushMessageOpened(pushContent: ["source": "xennio", "pushId": "123123", "campaignId": "campaign", "campaignDate": "campaignDate"])

        let captured = entitySerializerService.getCapturedEvent()

        XCTAssertFalse(httpService.hasError)

        XCTAssertTrue("o" == captured["n"] as! String?)
        XCTAssertTrue("campaign" == captured["ci"] as! String?)
        XCTAssertTrue("123123" == captured["pi"] as! String?)
        XCTAssertTrue("campaignDate" == captured["cd"] as! String?)
    }

    func test_it_should_not_construct_push_opened_event_and_make_api_call_when_source_is_not_defined() {
        let httpService = FakeHttpService(
            sdkKey: "sdk-key",
            session: FakeUrlSession(),
            collectorUrl: "https://c.xenn.io",
            apiUrl: "https://api.xenn.io"
        )
        let entitySerializerService = CapturingEntitySerializerService.init()
        let notificationProcessorHandler = NotificationProcessorHandler(httpService: httpService, entitySerializerService: entitySerializerService)
        entitySerializerService.givenSerializeReturns(callWith: TestUtils.anyDictionary(), expect: "serialized_event")
        httpService.givenPostWithPayload(callWith: "serialized_event")

        notificationProcessorHandler.pushMessageOpened(pushContent: ["pushId": "123123", "campaignId": "campaign", "campaignDate": "campaignDate"])

        let captured = entitySerializerService.getCapturedEvent()

        XCTAssertFalse(httpService.hasError)

        XCTAssertNil(captured["n"])
        XCTAssertNil(captured["ci"])
        XCTAssertNil(captured["pi"])
        XCTAssertNil(captured["cd"])
    }

    func test_it_should_not_construct_push_opened_event_and_make_api_call_when_source_is_defined_other_than_xennio() {
        let httpService = FakeHttpService(
            sdkKey: "sdk-key",
            session: FakeUrlSession(),
            collectorUrl: "https://c.xenn.io",
            apiUrl: "https://api.xenn.io"
        )
        let entitySerializerService = CapturingEntitySerializerService.init()
        let notificationProcessorHandler = NotificationProcessorHandler(httpService: httpService, entitySerializerService: entitySerializerService)
        entitySerializerService.givenSerializeReturns(callWith: TestUtils.anyDictionary(), expect: "serialized_event")
        httpService.givenPostWithPayload(callWith: "serialized_event")

        notificationProcessorHandler.pushMessageOpened(pushContent: ["source": "mennio", "pushId": "123123", "campaignId": "campaign", "campaignDate": "campaignDate"])

        let captured = entitySerializerService.getCapturedEvent()

        XCTAssertFalse(httpService.hasError)

        XCTAssertNil(captured["n"])
        XCTAssertNil(captured["ci"])
        XCTAssertNil(captured["pi"])
        XCTAssertNil(captured["cd"])
    }
}
