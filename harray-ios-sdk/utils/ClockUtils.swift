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
    private static var currentTime: Int!

    private init() {

    }

    class func getTime() -> Int {
        if isFrozen {
            return currentTime
        }
        return Int(Date().timeIntervalSince1970) * 1000
    }

    class func freeze() {
        isFrozen = true
        currentTime = Int(Date().timeIntervalSince1970) * 1000
    }

    class func freeze(expectedTime: Int) {
        isFrozen = true
        currentTime = expectedTime
    }

    class func unFreeze() {
        isFrozen = false
        currentTime = 0
    }
}
