//
//  ApiGetJsonRequest.swift
//  harray-ios-sdkTests
//
//  Created by Bay Batu on 29.01.2021.
//  Copyright © 2021 xennio. All rights reserved.
//

import XCTest

class ApiGetJsonRequestTest: XCTestCase {
    
    func test_it_should_construct_get_api_request() {
        let apiGetJsonRequest = ApiGetJsonRequest(endpoint: "http://api.xenn.io/get?param=value")
        
        let urlRequest = apiGetJsonRequest.getUrlRequest()
        
        XCTAssertEqual("http://api.xenn.io/get?param=value", urlRequest.url?.absoluteString)
        XCTAssertEqual("GET", urlRequest.httpMethod!)
        XCTAssertEqual("application/json", urlRequest.value(forHTTPHeaderField: "Accept")!)
    }
}
