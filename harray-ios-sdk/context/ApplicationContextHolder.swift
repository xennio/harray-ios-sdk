//
//  ApplicationContextHolder.swift
//  harray-ios-sdk
//
//  Created by YILDIRIM ADIGÜZEL on 21.04.2020.
//  Copyright © 2020 xennio. All rights reserved.
//

import Foundation

class ApplicationContextHolder {
    private let persistentId: String
    private let sdkVersion = "1.8"

    init(userDefaults: UserDefaults) {
        var value = userDefaults.string(forKey: Constants.SDK_PERSISTENT_ID_KEY.rawValue)
        if value == nil {
            value = RandomValueUtils.randomUUID()
            userDefaults.set(value, forKey: Constants.SDK_PERSISTENT_ID_KEY.rawValue)
        }
        self.persistentId = value!
    }

    func getPersistentId() -> String {
        return self.persistentId
    }

    func getTimezone() -> String {
        return String(TimeZone.current.secondsFromGMT() / 3600)
    }

    func getSdkVersion() -> String {
        return self.sdkVersion
    }
}
