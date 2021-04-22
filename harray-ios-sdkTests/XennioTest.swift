//
// Created by YILDIRIM ADIGÜZEL on 23.04.2020.
// Copyright (c) 2020 xennio. All rights reserved.
//

import XCTest

class XennioTest: XCTestCase {

    func test_it_should_throw_error_when_try_to_get_instance_without_invoking_configuration() throws {
        do {
            try Xennio.eventing()
        } catch XennError.configuration(let message) {
            XCTAssertEqual("Xennio.configure(xennConfig: XennConfig) must be called before getting instance", message)
        }
    }

    func test_it_should_return_same_instance_when_get_method_called_more_than_one_time() {
        Xennio.configure(xennConfig: XennConfig.create(sdkKey: "SDK_KEY", collectorUrl: "https://c.xenn.io"))
        let instance1 = try Xennio.getInstance()
        let instance2 = try Xennio.getInstance()
        XCTAssertEqual(instance1, instance2)
    }

    func test_it_should_log_in_with_memberId() {
        Xennio.configure(xennConfig: XennConfig.create(sdkKey: "SDK_KEY", collectorUrl: "https://c.xenn.io"))
        Xennio.login(memberId: "memberId")
        XCTAssertEqual("memberId", Xennio.instance!.sessionContextHolder.getMemberId())
    }

    func test_it_should_not_try_to_log_in_with_member_id_when_string_is_empty() {
        Xennio.configure(xennConfig: XennConfig.create(sdkKey: "SDK_KEY", collectorUrl: "https://c.xenn.io"))
        Xennio.login(memberId: "")
        XCTAssertNil(Xennio.instance!.sessionContextHolder.getMemberId())
    }

    func test_it_should_log_out_with_memberId() {
        Xennio.configure(xennConfig: XennConfig.create(sdkKey: "SDK_KEY", collectorUrl: "https://c.xenn.io"))
        Xennio.login(memberId: "memberId")
        XCTAssertEqual("memberId", Xennio.instance!.sessionContextHolder.getMemberId())
        Xennio.logout()
        XCTAssertNil(Xennio.instance!.sessionContextHolder.getMemberId())
    }
}
