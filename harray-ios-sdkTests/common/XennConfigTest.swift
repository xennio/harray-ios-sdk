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
        
        let xennConfig = XennConfig.create(sdkKey: "sdkKey")
        
        XCTAssertEqual("sdkKey", xennConfig.getSdkKey())
        XCTAssertEqual("https://c.xenn.io", xennConfig.getCollectorUrl())
        XCTAssertEqual("https://api.xenn.io", xennConfig.getApiUrl())
    }
    
    func test_it_should_create_xenn_config_with_custom_api_url_and_collector_url() {
        
        let xennConfig = XennConfig
            .create(sdkKey: "sdkKey")
            .collectorUrl(url: "https://collector.xenn.io/")
            .apiUrl(url: "https://myapi.xenn.io/")
        
        XCTAssertEqual("sdkKey", xennConfig.getSdkKey())
        XCTAssertEqual("https://collector.xenn.io", xennConfig.getCollectorUrl())
        XCTAssertEqual("https://myapi.xenn.io", xennConfig.getApiUrl())
    }
}
