//
//  ClockUtilsTest.swift
//  harray-ios-sdkTests
//
//  Created by YILDIRIM ADIGÜZEL on 21.04.2020.
//  Copyright © 2020 xennio. All rights reserved.
//

import XCTest

class ClockUtilsTest: XCTestCase {

    func test_it_should_get_current_time_if_it_is_not_frozen() {
        let time1 = ClockUtils.getTime()
        sleep(4)
        let time2 = ClockUtils.getTime()
        XCTAssertNotEqual(time1, time2)
    }

    func test_it_should_get_same_timestamp_if_it_is_frozen() {
        ClockUtils.freeze()
        let time1 = ClockUtils.getTime()
        sleep(4)
        let time2 = ClockUtils.getTime()
        XCTAssertEqual(time1, time2)
        ClockUtils.unFreeze()
    }

    func test_it_should_get_given_timestamp_if_it_is_frozen() {
        let expectedTime: Int64 = 1587133370000
        ClockUtils.freeze(expectedTime: expectedTime)
        let time1 = ClockUtils.getTime()
        let time2 = ClockUtils.getTime()
        XCTAssertEqual(time1, time2)
        ClockUtils.unFreeze()
    }
}
