//
//  ClockUtils.swift
//  harray-ios-sdk
//
//  Created by YILDIRIM ADIGÜZEL on 21.04.2020.
//  Copyright © 2020 xennio. All rights reserved.
//

import Foundation

class ClockUtils {

    private static var isFrozen: Bool = false
    private static var currentTime: Int64!

    private init() {

    }

    class func getTime() -> Int64 {
        if isFrozen {
            return currentTime
        }
        return Int64(Date().timeIntervalSince1970) * 1000
    }

    class func freeze() {
        isFrozen = true
        currentTime = Int64(Date().timeIntervalSince1970) * 1000
    }

    class func freeze(expectedTime: Int64) {
        isFrozen = true
        currentTime = expectedTime
    }

    class func unFreeze() {
        isFrozen = false
        currentTime = 0
    }
}
