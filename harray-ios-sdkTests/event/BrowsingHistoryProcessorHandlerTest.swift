//
//  BrowsingHistoryProcessorHandlerTest.swift
//  harray-ios-sdkTests
//
//  Created by Bay Batu on 14.06.2021.
//  Copyright © 2021 xennio. All rights reserved.
//

import XCTest

class BrowsingHistoryProcessorHandlerTest: XCTestCase {

    func test_it_should_construct_browsing_history_request_and_make_api_get_call() {

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
                path: "/browsing-history",
                params: [
                    "sdkKey": "sdkKey",
                    "pid": "fake-persistent-id",
                    "memberId": "fake-member-id",
                    "size": "5",
                    "entityName": "entityName"
                ],
                httpResult: HttpResult(statusCode: 200, hasError: false, body: apiJsonResponse)
        )

        let jsonDeserializerService = FakeJsonDeserializerService()
        jsonDeserializerService.givenDeserializeReturnsToDictArray(callWith: apiJsonResponse, expect: [["id": "id1", "name": "name1"], ["id": "id2", "name": "name2"]])

        let handler = BrowsingHistoryProcessorHandler(
                applicationContextHolder: FakeApplicationContextHolder(userDefaults: InitializedUserDefaults()),
                sessionContextHolder: FakeSessionContextHolder(),
                httpService: httpService,
                sdkKey: "sdkKey",
                jsonDeserializerService: jsonDeserializerService)

        handler.getBrowsingHistory(entityName: "entityName", size: 5, callback: { (result) in
            actualResult = result
        })

        XCTAssertEqual(actualResult?.count, 2)
        XCTAssertEqual(actualResult?[0]["id"], "id1")
        XCTAssertEqual(actualResult?[0]["name"], "name1")
        XCTAssertEqual(actualResult?[1]["id"], "id2")
        XCTAssertEqual(actualResult?[1]["name"], "name2")
    }

    func test_it_should_construct_browsing_history_request_without_memberId_and_make_api_get_call() {

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
                path: "/browsing-history",
                params: [
                    "sdkKey": "sdkKey",
                    "pid": "fake-persistent-id",
                    "entityName": "entityName",
                    "size": "5"
                ],
                httpResult: HttpResult(statusCode: 200, hasError: false, body: apiJsonResponse)
        )

        let jsonDeserializerService = FakeJsonDeserializerService()
        jsonDeserializerService.givenDeserializeReturnsToDictArray(callWith: apiJsonResponse, expect: [["id": "id1", "name": "name1"], ["id": "id2", "name": "name2"]])

        let sessionContextHolder = FakeSessionContextHolder()
        sessionContextHolder.setMemberId(memberId: nil)

        let handler = BrowsingHistoryProcessorHandler(
                applicationContextHolder: FakeApplicationContextHolder(userDefaults: InitializedUserDefaults()),
                sessionContextHolder: sessionContextHolder,
                httpService: httpService,
                sdkKey: "sdkKey",
                jsonDeserializerService: jsonDeserializerService)

        handler.getBrowsingHistory(entityName: "entityName", size: 5, callback: { (result) in
            actualResult = result
        })

        XCTAssertEqual(actualResult?.count, 2)
        XCTAssertEqual(actualResult?[0]["id"], "id1")
        XCTAssertEqual(actualResult?[0]["name"], "name1")
        XCTAssertEqual(actualResult?[1]["id"], "id2")
        XCTAssertEqual(actualResult?[1]["name"], "name2")
    }
}
