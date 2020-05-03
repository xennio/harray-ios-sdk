//
// Created by YILDIRIM ADIGÜZEL on 25.04.2020.
// Copyright (c) 2020 xennio. All rights reserved.
//

import XCTest

class HttpServiceTest: XCTestCase {

    func test_it_should_post_to_end_point_with_add_post_parameters() {
        let fakeUrlSession = MockUrlSession(httpResult: HttpResult(statusCode: 201, hasError: false))
        let httpService = HttpService(collectorUrl: "https://c.xenn.io", session: fakeUrlSession)

        var result: HttpResult?
        httpService.postFormUrlEncoded(payload: "payload") {
            result = $0
        }
        XCTAssertEqual(201, result!.getStatusCode())
        XCTAssertTrue(result!.isSuccess())
    }

    func test_it_should_respond_with_client_error_when_payload_is_nill() {
        let fakeUrlSession = MockUrlSession(httpResult: HttpResult.clientError())
        let httpService = HttpService(collectorUrl: "https://c.xenn.io", session: fakeUrlSession)

        var result: HttpResult?
        httpService.postFormUrlEncoded(payload: nil) {
            result = $0
        }
        XCTAssertEqual(0, result!.getStatusCode())
        XCTAssertFalse(result!.isSuccess())
    }

    func test_it_should_call_completion_handler_with_nil_when_endpoint_is_nil() {
        let fakeUrlSession = MockUrlSession(httpResult: HttpResult.clientError())
        let httpService = HttpService(collectorUrl: "https://c.xenn.io", session: fakeUrlSession)
        var result: HttpDownloadableResult?
        httpService.downloadContent(endpoint: nil) {
            result = $0
        }
        XCTAssertNil(result)
    }

    func test_it_should_call_completion_handler_with_http_downloadable_result_when_response_is_valid() {
        let fakeUrlSession = MockUrlSession(httpDownloadableResult: HttpDownloadableResult(path: URL(string: "http://www.xenn.io")!))
        let httpService = HttpService(collectorUrl: "https://c.xenn.io", session: fakeUrlSession)
        var result: HttpDownloadableResult?
        httpService.downloadContent(endpoint: "https://c.xenn.io/img.gif") {
            result = $0
        }
        XCTAssertEqual(URL(string: "http://www.xenn.io")!,result?.getPath())
    }

}