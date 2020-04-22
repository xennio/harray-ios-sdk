//
//  RandomValueUtilsTest.swift
//  harray-ios-sdkTests
//
//  Created by YILDIRIM ADIGÜZEL on 21.04.2020.
//  Copyright © 2020 xennio. All rights reserved.
//

import XCTest

class RandomValueUtilsTest: XCTestCase {

    func test_it_should_generate_random_value_if_it_is_not_frozen() {
        let random1 = RandomValueUtils.randomUUID()
        let random2 = RandomValueUtils.randomUUID()
        XCTAssertNotEqual(random1, random2)
    }
       
   func test_it_should_not_generate_new_value_if_it_is_frozen() {
        RandomValueUtils.freeze()
        let random1 = RandomValueUtils.randomUUID()
        let random2 = RandomValueUtils.randomUUID()
        XCTAssertEqual(random1, random2)
        RandomValueUtils.unFreeze()
   }
  

}
