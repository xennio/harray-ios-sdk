//
// Created by Yildirim Adiguzel on 3.05.2020.
// Copyright (c) 2020 xennio. All rights reserved.
//

import XCTest

class PostJsonEncodedRequestTest: XCTestCase {

    func test_it_should_construct_post_json_encoded_request() {
        let postJsonEncodedRequest = PostJsonEncodedRequest(payload: "{\"foo\":\"bar\"}", endpoint: "http://c.xenn.io")

        let urlRequest = postJsonEncodedRequest.getUrlRequest()
        let expectedBody = "{\"foo\":\"bar\"}".data(using: String.Encoding.ascii, allowLossyConversion: false)

        XCTAssertEqual("POST", urlRequest.httpMethod!)
        XCTAssertEqual("application/json", urlRequest.value(forHTTPHeaderField: "Content-Type")!)
        XCTAssertEqual(expectedBody, urlRequest.httpBody!)
    }

}