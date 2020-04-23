//
// Created by YILDIRIM ADIGÜZEL on 23.04.2020.
// Copyright (c) 2020 xennio. All rights reserved.
//

import XCTest

class XennioTest: XCTestCase {

    func test_it_should_throw_error_when_try_to_get_instance_without_invoking_configuration() throws {
        do {
            let eventing = try Xennio.eventing()
        } catch XennError.configuration(let message) {
            XCTAssertEqual("Xennio.configure(sdkKey: sdkKey) must be called before getting instance", message)
        }
    }

    func test_it_should_return_same_instance_when_get_method_called_more_than_one_time() throws {
        Xennio.configure(skdKey: "SDK_KEY")
        let instance1 = try Xennio.getInstance()
        let instance2 = try Xennio.getInstance()
        XCTAssertEqual(instance1, instance2)
    }


}