//
//  PushMessagesHistoryProcessorHandlerTest.swift
//  harray-ios-sdkTests
//
//  Created by Bay Batu on 29.09.2021.
//  Copyright © 2021 xennio. All rights reserved.
//

import XCTest

class PushMessagesHistoryProcessorHandlerTest: XCTestCase {

    func test_it_should_construct_push_messages_history_request_and_make_api_get_call() {

        var actualResult: Array<Dictionary<String, String>>?

        let apiJsonResponse = """
                                  [
                                      { "id": "id1", "name": "name1" },
                                      { "id": "id2", "name": "name2" }
                                  ]
                              """
        let httpService = FakeHttpService(
                sdkKey: "sdkKey",
                session: FakeUrlSession(),
                collectorUrl: "https://c.xenn.io",
                apiUrl: "https://api.xenn.io"
        )
        httpService.givenGetApiRequest(
                path: "/push-messages-history",
                params: [
                    "sdkKey": "sdkKey",
                    "memberId": "fake-member-id",
                    "size": "5"
                ],
                httpResult: HttpResult(statusCode: 200, hasError: false, body: apiJsonResponse)
        )

        let jsonDeserializerService = FakeJsonDeserializerService()
        jsonDeserializerService.givenDeserializeReturnsToDictArray(callWith: apiJsonResponse, expect: [["id": "id1", "name": "name1"], ["id": "id2", "name": "name2"]])

        let handler = PushMessagesHistoryProcessorHandler(
                sessionContextHolder: FakeSessionContextHolder(),
                httpService: httpService,
                sdkKey: "sdkKey",
                jsonDeserializerService: jsonDeserializerService)

        handler.getPushMessagesHistory(size: 5, callback: { (result) in
            actualResult = result
        })

        XCTAssertEqual(actualResult?.count, 2)
        XCTAssertEqual(actualResult?[0]["id"], "id1")
        XCTAssertEqual(actualResult?[0]["name"], "name1")
        XCTAssertEqual(actualResult?[1]["id"], "id2")
        XCTAssertEqual(actualResult?[1]["name"], "name2")
    }
}
