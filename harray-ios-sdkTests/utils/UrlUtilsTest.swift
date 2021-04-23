//
//  UrlUtilsTest.swift
//  harray-ios-sdkTests
//
//  Created by Bay Batu on 21.04.2021.
//  Copyright © 2021 xennio. All rights reserved.
//

import Foundation

import XCTest

class UrlUtilsTest: XCTestCase {

    func test_it_should_remove_trailing_slash_from_url_if_exists() {
        XCTAssertEqual("http://xenn.io", UrlUtils.removeTrailingSlash(url: "http://xenn.io/"))
        XCTAssertEqual("http://xenn.io", UrlUtils.removeTrailingSlash(url: "http://xenn.io"))
    }
}
