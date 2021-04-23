//
//  XennConfigTest.swift
//  harray-ios-sdkTests
//
//  Created by Bay Batu on 21.04.2021.
//  Copyright © 2021 xennio. All rights reserved.
//

import XCTest

class XennConfigTest: XCTestCase {

    func test_it_should_create_xenn_config() {

        let xennConfig = XennConfig.create(sdkKey: "sdkKey", collectorUrl: "https://c.xenn.io")

        XCTAssertEqual("sdkKey", xennConfig.getSdkKey())
        XCTAssertEqual("https://c.xenn.io", xennConfig.getCollectorUrl())
        XCTAssertEqual("https://api.xenn.io", xennConfig.getApiUrl())
    }

    func test_it_should_create_xenn_config_with_custom_apiUrl() {

        let xennConfig = XennConfig
                .create(sdkKey: "sdkKey", collectorUrl: "https://c.xenn.io/")
                .apiUrl(url: "https://myapi.xenn.io/")

        XCTAssertEqual("sdkKey", xennConfig.getSdkKey())
        XCTAssertEqual("https://c.xenn.io", xennConfig.getCollectorUrl())
        XCTAssertEqual("https://myapi.xenn.io", xennConfig.getApiUrl())
    }
}
