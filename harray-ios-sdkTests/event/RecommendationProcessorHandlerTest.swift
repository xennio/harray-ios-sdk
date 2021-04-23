//
//  RecommendationProcessorHandlerTest.swift
//  harray-ios-sdkTests
//
//  Created by Bay Batu on 29.01.2021.
//  Copyright © 2021 xennio. All rights reserved.
//

import XCTest

class RecommendationProcessorHandlerTest: XCTestCase {
    
    func test_it_should_construct_reco_request_and_make_api_get_call() {
        
        var actualRecoResult: Array<Dictionary<String, String>>?
        
        let recoApiJsonResponse = """
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
            path: "/recommendation",
            params: [
                "sdkKey": "sdkKey",
                "pid": "fake-persistent-id",
                "memberId": "fake-member-id",
                "size": "4",
                "entityId": "entityId",
                "boxId": "boxId"
            ],
            httpResult: HttpResult(statusCode: 200, hasError: false, body: recoApiJsonResponse)
        )
        
        let jsonDeserializerService = FakeJsonDeserializerService()
        jsonDeserializerService.givenDeserializeReturnsToDictArray(callWith: recoApiJsonResponse, expect: [["id": "id1", "name": "name1"], ["id": "id2", "name": "name2"]])
        
        let recoHandler = RecommendationProcessorHandler(
            applicationContextHolder: FakeApplicationContextHolder(userDefaults: InitializedUserDefaults()),
            sessionContextHolder: FakeSessionContextHolder(),
            httpService: httpService,
            sdkKey: "sdkKey",
            jsonDeserializerService: jsonDeserializerService)
        
        recoHandler.getRecommendations(boxId: "boxId", entityId: "entityId", size: 4) { (recoResult) in
            actualRecoResult = recoResult
        }
        
        XCTAssertEqual(actualRecoResult?.count, 2)
        XCTAssertEqual(actualRecoResult?[0]["id"], "id1")
        XCTAssertEqual(actualRecoResult?[0]["name"], "name1")
        XCTAssertEqual(actualRecoResult?[1]["id"], "id2")
        XCTAssertEqual(actualRecoResult?[1]["name"], "name2")
    }
    
    func test_it_should_make_reco_request_and_process_nil_body_when_response_has_no_body() {
        
        var actualRecoResult: Array<Dictionary<String, String>>?
        
        let httpService = FakeHttpService(
            sdkKey: "sdkKey",
            session: FakeUrlSession(),
            collectorUrl: "https://c.xenn.io",
            apiUrl: "https://api.xenn.io"
        )
        httpService.givenGetApiRequest(
            path: "/recommendation",
            params: [
                "sdkKey": "sdkKey",
                "pid": "fake-persistent-id",
                "memberId": "fake-member-id",
                "size": "4",
                "entityId": "entityId",
                "boxId": "boxId"
            ],
            httpResult: HttpResult(statusCode: 200, hasError: false, body: nil)
        )
        
        let recoHandler = RecommendationProcessorHandler(
            applicationContextHolder: FakeApplicationContextHolder(userDefaults: InitializedUserDefaults()),
            sessionContextHolder: FakeSessionContextHolder(),
            httpService: httpService,
            sdkKey: "sdkKey",
            jsonDeserializerService: FakeJsonDeserializerService())
        
        recoHandler.getRecommendations(boxId: "boxId", entityId: "entityId", size: 4) { (recoResult) in
            actualRecoResult = recoResult
        }
        
        XCTAssertNil(actualRecoResult)
    }
    
    func test_it_should_construct_reco_request_without_entity_and_make_api_get_call() {
        
        var actualRecoResult: Array<Dictionary<String, String>>?
        
        let recoApiJsonResponse = """
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
            path: "/recommendation",
            params: [
                "sdkKey": "sdkKey",
                "pid": "fake-persistent-id",
                "memberId": "fake-member-id",
                "size": "4",
                "boxId": "boxId"
            ],
            httpResult: HttpResult(statusCode: 200, hasError: false, body: recoApiJsonResponse)
        )
        
        let jsonDeserializerService = FakeJsonDeserializerService()
        jsonDeserializerService.givenDeserializeReturnsToDictArray(callWith: recoApiJsonResponse, expect: [["id": "id1", "name": "name1"], ["id": "id2", "name": "name2"]])
        
        let recoHandler = RecommendationProcessorHandler(
            applicationContextHolder: FakeApplicationContextHolder(userDefaults: InitializedUserDefaults()),
            sessionContextHolder: FakeSessionContextHolder(),
            httpService: httpService,
            sdkKey: "sdkKey",
            jsonDeserializerService: jsonDeserializerService)
        
        recoHandler.getRecommendations(boxId: "boxId", entityId: nil, size: 4) { (recoResult) in
            actualRecoResult = recoResult
        }
        
        XCTAssertEqual(actualRecoResult?.count, 2)
        XCTAssertEqual(actualRecoResult?[0]["id"], "id1")
        XCTAssertEqual(actualRecoResult?[0]["name"], "name1")
        XCTAssertEqual(actualRecoResult?[1]["id"], "id2")
        XCTAssertEqual(actualRecoResult?[1]["name"], "name2")
    }
    
    func test_it_should_construct_reco_request_without_memberId_and_make_api_get_call() {
        
        var actualRecoResult: Array<Dictionary<String, String>>?
        
        let recoApiJsonResponse = """
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
            path: "/recommendation",
            params: [
                "sdkKey": "sdkKey",
                "pid": "fake-persistent-id",
                "entityId": "entityId",
                "size": "4",
                "boxId": "boxId"
            ],
            httpResult: HttpResult(statusCode: 200, hasError: false, body: recoApiJsonResponse)
        )
        
        let jsonDeserializerService = FakeJsonDeserializerService()
        jsonDeserializerService.givenDeserializeReturnsToDictArray(callWith: recoApiJsonResponse, expect: [["id": "id1", "name": "name1"], ["id": "id2", "name": "name2"]])
        
        let sessionContextHolder = FakeSessionContextHolder()
        sessionContextHolder.setMemberId(memberId: nil)
        
        let recoHandler = RecommendationProcessorHandler(
            applicationContextHolder: FakeApplicationContextHolder(userDefaults: InitializedUserDefaults()),
            sessionContextHolder: sessionContextHolder,
            httpService: httpService,
            sdkKey: "sdkKey",
            jsonDeserializerService: jsonDeserializerService)
        
        recoHandler.getRecommendations(boxId: "boxId", entityId: "entityId", size: 4) { (recoResult) in
            actualRecoResult = recoResult
        }
        
        XCTAssertEqual(actualRecoResult?.count, 2)
        XCTAssertEqual(actualRecoResult?[0]["id"], "id1")
        XCTAssertEqual(actualRecoResult?[0]["name"], "name1")
        XCTAssertEqual(actualRecoResult?[1]["id"], "id2")
        XCTAssertEqual(actualRecoResult?[1]["name"], "name2")
    }
}
