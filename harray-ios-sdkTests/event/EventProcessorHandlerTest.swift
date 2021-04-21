//
//  EventProcessorHandlerTest.swift
//  harray-ios-sdkTests
//
//  Created by YILDIRIM ADIGÜZEL on 21.04.2020.
//  Copyright © 2020 xennio. All rights reserved.
//

import XCTest

class EventProcessorHandlerTest: XCTestCase {

    func test_it_should_construct_page_view_event_and_make_api_call() {
        let sessionContextHolder = FakeSessionContextHolder().withExtraParameters(["utm_medium": "xennio"])
        let applicationContextHolder = FakeApplicationContextHolder(userDefaults: InitializedUserDefaults())

        let httpService = FakeHttpService(
            sdkKey: "sdk-key",
            session: FakeUrlSession(),
            collectorUrl: "https://c.xenn.io",
            apiUrl: "https://api.xenn.io"
        )
        let entitySerializerService = CapturingEntitySerializerService.init()
        let eventProcessorHandler = EventProcessorHandler(applicationContextHolder: applicationContextHolder, sessionContextHolder: sessionContextHolder, httpService: httpService, entitySerializerService: entitySerializerService)
        entitySerializerService.givenSerializeReturns(callWith: TestUtils.anyDictionary(), expect: "serialized_event")
        httpService.givenPostWithPayload(callWith: "serialized_event")

        eventProcessorHandler.pageView(pageType: "homePage")

        let captured = entitySerializerService.getCapturedEvent()

        XCTAssertFalse(httpService.hasError)

        let header = captured["h"] as! Dictionary<String, Any>
        let body = captured["b"] as! Dictionary<String, Any>

        XCTAssertTrue("PV" == header["n"] as! String)
        XCTAssertTrue(applicationContextHolder.getPersistentId() == header["p"] as! String)
        XCTAssertTrue(sessionContextHolder.getSessionId() == header["s"] as! String)
        XCTAssertTrue(sessionContextHolder.getMemberId() == body["memberId"] as! String)
        XCTAssertTrue("homePage" == body["pageType"] as! String)
        XCTAssertTrue("xennio" == body["utm_medium"] as! String)
    }

    func test_it_should_construct_page_view_and_append_extra_params_to_event_and_make_api_call() {
        let sessionContextHolder = FakeSessionContextHolder().withExtraParameters(["utm_medium": "xennio"])
        let applicationContextHolder = FakeApplicationContextHolder(userDefaults: InitializedUserDefaults())

        let httpService = FakeHttpService(
            sdkKey: "sdk-key",
            session: FakeUrlSession(),
            collectorUrl: "https://c.xenn.io",
            apiUrl: "https://api.xenn.io"
        )

        let entitySerializerService = CapturingEntitySerializerService.init()
        let eventProcessorHandler = EventProcessorHandler(applicationContextHolder: applicationContextHolder, sessionContextHolder: sessionContextHolder, httpService: httpService, entitySerializerService: entitySerializerService)
        entitySerializerService.givenSerializeReturns(callWith: TestUtils.anyDictionary(), expect: "serialized_event")
        httpService.givenPostWithPayload(callWith: "serialized_event")

        eventProcessorHandler.pageView(pageType: "homePage", params: ["param1": "value1", "param2": 1])

        let captured = entitySerializerService.getCapturedEvent()

        XCTAssertFalse(httpService.hasError)

        let header = captured["h"] as! Dictionary<String, Any>
        let body = captured["b"] as! Dictionary<String, Any>

        XCTAssertTrue("PV" == header["n"] as! String)
        XCTAssertTrue(applicationContextHolder.getPersistentId() == header["p"] as! String)
        XCTAssertTrue(sessionContextHolder.getSessionId() == header["s"] as! String)
        XCTAssertTrue(sessionContextHolder.getMemberId() == body["memberId"] as! String)
        XCTAssertTrue("homePage" == body["pageType"] as! String)
        XCTAssertTrue("xennio" == body["utm_medium"] as! String)
        XCTAssertTrue("value1" == body["param1"] as! String)
        XCTAssertTrue(1 == body["param2"] as! Int)
    }

    func test_it_should_not_invoke_http_service_when_serializer_service_has_error_on_page_view() {
        let sessionContextHolder = FakeSessionContextHolder().withExtraParameters(["utm_medium": "xennio"])
        let applicationContextHolder = FakeApplicationContextHolder(userDefaults: InitializedUserDefaults())

        let httpService = FakeHttpService(
            sdkKey: "sdk-key",
            session: FakeUrlSession(),
            collectorUrl: "https://c.xenn.io",
            apiUrl: "https://api.xenn.io"
        )
        let entitySerializerService = CapturingEntitySerializerService.init()
        let eventProcessorHandler = EventProcessorHandler(applicationContextHolder: applicationContextHolder, sessionContextHolder: sessionContextHolder, httpService: httpService, entitySerializerService: entitySerializerService)
        entitySerializerService.givenSerializeReturns(callWith: TestUtils.anyDictionary(), expect: nil)

        eventProcessorHandler.pageView(pageType: "homePage", params: ["param1": "value1", "param2": 1])

        XCTAssertNil(httpService.expectedPayload)
    }

    func test_it_should_construct_action_result_event_and_make_api_call() {
        let sessionContextHolder = FakeSessionContextHolder()
        let applicationContextHolder = FakeApplicationContextHolder(userDefaults: InitializedUserDefaults())

        let httpService = FakeHttpService(
            sdkKey: "sdk-key",
            session: FakeUrlSession(),
            collectorUrl: "https://c.xenn.io",
            apiUrl: "https://api.xenn.io"
        )
        let entitySerializerService = CapturingEntitySerializerService.init()
        let eventProcessorHandler = EventProcessorHandler(applicationContextHolder: applicationContextHolder, sessionContextHolder: sessionContextHolder, httpService: httpService, entitySerializerService: entitySerializerService)
        entitySerializerService.givenSerializeReturns(callWith: TestUtils.anyDictionary(), expect: "serialized_event")
        httpService.givenPostWithPayload(callWith: "serialized_event")

        eventProcessorHandler.actionResult(type: "conversion")

        let captured = entitySerializerService.getCapturedEvent()

        XCTAssertFalse(httpService.hasError)

        let header = captured["h"] as! Dictionary<String, Any>
        let body = captured["b"] as! Dictionary<String, Any>

        XCTAssertTrue("AR" == header["n"] as! String)
        XCTAssertTrue(applicationContextHolder.getPersistentId() == header["p"] as! String)
        XCTAssertTrue(sessionContextHolder.getSessionId() == header["s"] as! String)
        XCTAssertTrue(sessionContextHolder.getMemberId() == body["memberId"] as! String)
        XCTAssertTrue("conversion" == body["type"] as! String)
    }

    func test_it_should_construct_action_result_event_and_append_extra_params_to_event_and_make_api_call() {
        let sessionContextHolder = FakeSessionContextHolder()
        let applicationContextHolder = FakeApplicationContextHolder(userDefaults: InitializedUserDefaults())

        let httpService = FakeHttpService(
            sdkKey: "sdk-key",
            session: FakeUrlSession(),
            collectorUrl: "https://c.xenn.io",
            apiUrl: "https://api.xenn.io"
        )
        let entitySerializerService = CapturingEntitySerializerService.init()
        let eventProcessorHandler = EventProcessorHandler(applicationContextHolder: applicationContextHolder, sessionContextHolder: sessionContextHolder, httpService: httpService, entitySerializerService: entitySerializerService)
        entitySerializerService.givenSerializeReturns(callWith: TestUtils.anyDictionary(), expect: "serialized_event")
        httpService.givenPostWithPayload(callWith: "serialized_event")

        eventProcessorHandler.actionResult(type: "conversion", params: ["param1": "value1", "param2": 1])

        let captured = entitySerializerService.getCapturedEvent()

        XCTAssertFalse(httpService.hasError)

        let header = captured["h"] as! Dictionary<String, Any>
        let body = captured["b"] as! Dictionary<String, Any>

        XCTAssertTrue("AR" == header["n"] as! String)
        XCTAssertTrue(applicationContextHolder.getPersistentId() == header["p"] as! String)
        XCTAssertTrue(sessionContextHolder.getSessionId() == header["s"] as! String)
        XCTAssertTrue(sessionContextHolder.getMemberId() == body["memberId"] as! String)
        XCTAssertTrue("conversion" == body["type"] as! String)
        XCTAssertTrue("value1" == body["param1"] as! String)
        XCTAssertTrue(1 == body["param2"] as! Int)
    }

    func test_it_should_not_invoke_http_service_when_serializer_service_has_error_on_action_result() {
        let sessionContextHolder = FakeSessionContextHolder().withExtraParameters(["utm_medium": "xennio"])
        let applicationContextHolder = FakeApplicationContextHolder(userDefaults: InitializedUserDefaults())

        let httpService = FakeHttpService(
            sdkKey: "sdk-key",
            session: FakeUrlSession(),
            collectorUrl: "https://c.xenn.io",
            apiUrl: "https://api.xenn.io"
        )
        let entitySerializerService = CapturingEntitySerializerService.init()
        let eventProcessorHandler = EventProcessorHandler(applicationContextHolder: applicationContextHolder, sessionContextHolder: sessionContextHolder, httpService: httpService, entitySerializerService: entitySerializerService)
        entitySerializerService.givenSerializeReturns(callWith: TestUtils.anyDictionary(), expect: nil)

        eventProcessorHandler.actionResult(type: "conversion", params: ["param1": "value1", "param2": 1])

        XCTAssertNil(httpService.expectedPayload)
    }

    func test_it_should_construct_impression_event_and_make_api_call() {
        let sessionContextHolder = FakeSessionContextHolder()
        let applicationContextHolder = FakeApplicationContextHolder(userDefaults: InitializedUserDefaults())

        let httpService = FakeHttpService(
            sdkKey: "sdk-key",
            session: FakeUrlSession(),
            collectorUrl: "https://c.xenn.io",
            apiUrl: "https://api.xenn.io"
        )
        let entitySerializerService = CapturingEntitySerializerService.init()
        let eventProcessorHandler = EventProcessorHandler(applicationContextHolder: applicationContextHolder, sessionContextHolder: sessionContextHolder, httpService: httpService, entitySerializerService: entitySerializerService)
        entitySerializerService.givenSerializeReturns(callWith: TestUtils.anyDictionary(), expect: "serialized_event")
        httpService.givenPostWithPayload(callWith: "serialized_event")

        eventProcessorHandler.impression(pageType: "productDetail")

        let captured = entitySerializerService.getCapturedEvent()

        XCTAssertFalse(httpService.hasError)

        let header = captured["h"] as! Dictionary<String, Any>
        let body = captured["b"] as! Dictionary<String, Any>

        XCTAssertTrue("IM" == header["n"] as! String)
        XCTAssertTrue(applicationContextHolder.getPersistentId() == header["p"] as! String)
        XCTAssertTrue(sessionContextHolder.getSessionId() == header["s"] as! String)
        XCTAssertTrue(sessionContextHolder.getMemberId() == body["memberId"] as! String)
        XCTAssertTrue("productDetail" == body["pageType"] as! String)
    }

    func test_it_should_construct_impression_event_and_append_extra_params_to_event_and_make_api_call() {
        let sessionContextHolder = FakeSessionContextHolder()
        let applicationContextHolder = FakeApplicationContextHolder(userDefaults: InitializedUserDefaults())

        let httpService = FakeHttpService(
            sdkKey: "sdk-key",
            session: FakeUrlSession(),
            collectorUrl: "https://c.xenn.io",
            apiUrl: "https://api.xenn.io"
        )
        let entitySerializerService = CapturingEntitySerializerService.init()
        let eventProcessorHandler = EventProcessorHandler(applicationContextHolder: applicationContextHolder, sessionContextHolder: sessionContextHolder, httpService: httpService, entitySerializerService: entitySerializerService)
        entitySerializerService.givenSerializeReturns(callWith: TestUtils.anyDictionary(), expect: "serialized_event")
        httpService.givenPostWithPayload(callWith: "serialized_event")

        eventProcessorHandler.impression(pageType: "productDetail", params: ["param1": "value1", "param2": 1])

        let captured = entitySerializerService.getCapturedEvent()

        XCTAssertFalse(httpService.hasError)

        let header = captured["h"] as! Dictionary<String, Any>
        let body = captured["b"] as! Dictionary<String, Any>

        XCTAssertTrue("IM" == header["n"] as! String)
        XCTAssertTrue(applicationContextHolder.getPersistentId() == header["p"] as! String)
        XCTAssertTrue(sessionContextHolder.getSessionId() == header["s"] as! String)
        XCTAssertTrue(sessionContextHolder.getMemberId() == body["memberId"] as! String)
        XCTAssertTrue("productDetail" == body["pageType"] as! String)
        XCTAssertTrue("value1" == body["param1"] as! String)
        XCTAssertTrue(1 == body["param2"] as! Int)
    }

    func test_it_should_not_invoke_http_service_when_serializer_service_has_error_on_impression() {
        let sessionContextHolder = FakeSessionContextHolder().withExtraParameters(["utm_medium": "xennio"])
        let applicationContextHolder = FakeApplicationContextHolder(userDefaults: InitializedUserDefaults())

        let httpService = FakeHttpService(
            sdkKey: "sdk-key",
            session: FakeUrlSession(),
            collectorUrl: "https://c.xenn.io",
            apiUrl: "https://api.xenn.io"
        )
        let entitySerializerService = CapturingEntitySerializerService.init()
        let eventProcessorHandler = EventProcessorHandler(applicationContextHolder: applicationContextHolder, sessionContextHolder: sessionContextHolder, httpService: httpService, entitySerializerService: entitySerializerService)
        entitySerializerService.givenSerializeReturns(callWith: TestUtils.anyDictionary(), expect: nil)

        eventProcessorHandler.impression(pageType: "productDetail", params: ["param1": "value1", "param2": 1])

        XCTAssertNil(httpService.expectedPayload)
    }


    func test_it_should_construct_custom_event_and_make_api_call() {
        let sessionContextHolder = FakeSessionContextHolder().withExtraParameters(["utm_medium": "xennio"])
        let applicationContextHolder = FakeApplicationContextHolder(userDefaults: InitializedUserDefaults())

        let httpService = FakeHttpService(
            sdkKey: "sdk-key",
            session: FakeUrlSession(),
            collectorUrl: "https://c.xenn.io",
            apiUrl: "https://api.xenn.io"
        )
        let entitySerializerService = CapturingEntitySerializerService.init()
        let eventProcessorHandler = EventProcessorHandler(applicationContextHolder: applicationContextHolder, sessionContextHolder: sessionContextHolder, httpService: httpService, entitySerializerService: entitySerializerService)
        entitySerializerService.givenSerializeReturns(callWith: TestUtils.anyDictionary(), expect: "serialized_event")
        httpService.givenPostWithPayload(callWith: "serialized_event")

        eventProcessorHandler.custom(eventName: "customEvent", params: ["param1": "value1", "param2": 1])

        let captured = entitySerializerService.getCapturedEvent()

        XCTAssertFalse(httpService.hasError)

        let header = captured["h"] as! Dictionary<String, Any>
        let body = captured["b"] as! Dictionary<String, Any>

        XCTAssertTrue("customEvent" == header["n"] as! String)
        XCTAssertTrue(applicationContextHolder.getPersistentId() == header["p"] as! String)
        XCTAssertTrue(sessionContextHolder.getSessionId() == header["s"] as! String)
        XCTAssertTrue(sessionContextHolder.getMemberId() == body["memberId"] as! String)
        XCTAssertTrue("value1" == body["param1"] as! String)
        XCTAssertTrue(1 == body["param2"] as! Int)
    }

    func test_it_should_not_invoke_http_service_when_serializer_service_has_error_on_custom_event() {
        let sessionContextHolder = FakeSessionContextHolder().withExtraParameters(["utm_medium": "xennio"])
        let applicationContextHolder = FakeApplicationContextHolder(userDefaults: InitializedUserDefaults())

        let httpService = FakeHttpService(
            sdkKey: "sdk-key",
            session: FakeUrlSession(),
            collectorUrl: "https://c.xenn.io",
            apiUrl: "https://api.xenn.io"
        )
        let entitySerializerService = CapturingEntitySerializerService.init()
        let eventProcessorHandler = EventProcessorHandler(applicationContextHolder: applicationContextHolder, sessionContextHolder: sessionContextHolder, httpService: httpService, entitySerializerService: entitySerializerService)
        entitySerializerService.givenSerializeReturns(callWith: TestUtils.anyDictionary(), expect: nil)

        eventProcessorHandler.custom(eventName: "customEvent", params: ["param1": "value1", "param2": 1])

        XCTAssertNil(httpService.expectedPayload)
    }

    func test_it_should_construct_save_push_token_event_and_make_api_call() {
        let sessionContextHolder = FakeSessionContextHolder()
        let applicationContextHolder = FakeApplicationContextHolder(userDefaults: InitializedUserDefaults())

        let httpService = FakeHttpService(
            sdkKey: "sdk-key",
            session: FakeUrlSession(),
            collectorUrl: "https://c.xenn.io",
            apiUrl: "https://api.xenn.io"
        )
        let entitySerializerService = CapturingEntitySerializerService.init()
        let eventProcessorHandler = EventProcessorHandler(applicationContextHolder: applicationContextHolder, sessionContextHolder: sessionContextHolder, httpService: httpService, entitySerializerService: entitySerializerService)

        entitySerializerService.givenSerializeReturns(callWith: TestUtils.anyDictionary(), expect: "serialized_event")
        httpService.givenPostWithPayload(callWith: "serialized_event")

        eventProcessorHandler.savePushToken(deviceToken: "token")

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
    
    func test_it_should_construct_remove_push_token_event_and_make_api_call() {
        let sessionContextHolder = FakeSessionContextHolder()
        let applicationContextHolder = FakeApplicationContextHolder(userDefaults: InitializedUserDefaults())

        let httpService = FakeHttpService(
            sdkKey: "sdk-key",
            session: FakeUrlSession(),
            collectorUrl: "https://c.xenn.io",
            apiUrl: "https://api.xenn.io"
        )
        let entitySerializerService = CapturingEntitySerializerService.init()
        let eventProcessorHandler = EventProcessorHandler(applicationContextHolder: applicationContextHolder, sessionContextHolder: sessionContextHolder, httpService: httpService, entitySerializerService: entitySerializerService)

        entitySerializerService.givenSerializeReturns(callWith: TestUtils.anyDictionary(), expect: "serialized_event")
        httpService.givenPostWithPayload(callWith: "serialized_event")

        eventProcessorHandler.removeTokenAssociation(deviceToken: "token")

        let captured = entitySerializerService.getCapturedEvent()

        XCTAssertFalse(httpService.hasError)

        let header = captured["h"] as! Dictionary<String, Any>
        let body = captured["b"] as! Dictionary<String, Any>

        XCTAssertTrue("TR" == header["n"] as! String)
        XCTAssertTrue(applicationContextHolder.getPersistentId() == header["p"] as! String)
        XCTAssertTrue(sessionContextHolder.getSessionId() == header["s"] as! String)
        XCTAssertTrue(sessionContextHolder.getMemberId() == body["memberId"] as! String)
        XCTAssertTrue("token" == body["deviceToken"] as! String)
        XCTAssertTrue("iosToken" == body["type"] as! String)
        XCTAssertTrue("iosAppPush" == body["appType"] as! String)
        XCTAssertTrue("pushToken" == body["name"] as! String)

    }
}
