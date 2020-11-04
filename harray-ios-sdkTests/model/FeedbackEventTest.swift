//
// Created by Yildirim Adiguzel on 3.05.2020.
// Copyright (c) 2020 xennio. All rights reserved.
//

import XCTest

class FeedbackEventTest: XCTestCase {

    func test_it_should_construct_fields_properly() {
        let feedbackType = "o"

        let feedbackEvent = FeedbackEvent
                .create(name: feedbackType)
                .addParameter(key: "header2", value: "value1")
                .addParameter(key: "header1", value: "value2")
                .addParameter(key: "body1", value: 1)

        let feedbackEventMap = feedbackEvent.toMap()

        XCTAssertTrue(feedbackType == feedbackEventMap["n"] as! String)
        XCTAssertTrue(1 == feedbackEventMap["body1"] as! Int)
        XCTAssertTrue("value1" == feedbackEventMap["header2"] as! String)
        XCTAssertTrue("value2" == feedbackEventMap["header1"] as! String)
    }
}
