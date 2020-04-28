//
// Created by YILDIRIM ADIGÜZEL on 27.04.2020.
// Copyright (c) 2020 xennio. All rights reserved.
//

import XCTest

class PostFormUrlEncodedRequestTest: XCTestCase {

    func test_it_should_construct_post_url_encoded_request() {
        let postFormUrlEncodedRequest = PostFormUrlEncodedRequest(payload: "payload", endpoint: "http://c.xenn.io")

        let urlRequest = postFormUrlEncodedRequest.getUrlRequest()
        let expectedBody = "e=payload".data(using: String.Encoding.ascii, allowLossyConversion: false)

        XCTAssertEqual("POST", urlRequest.httpMethod!)
        XCTAssertEqual("application/x-www-form-urlencoded", urlRequest.value(forHTTPHeaderField: "Content-Type")!)
        XCTAssertEqual(expectedBody, urlRequest.httpBody!)
    }
}