//
//  DeviceService.swift
//  harray-ios-sdk
//
//  Created by YILDIRIM ADIGÜZEL on 22.04.2020.
//  Copyright © 2020 xennio. All rights reserved.
//

import Foundation
import UIKit

class DeviceService {

    let uiDevice: UIDevice
    let bundle: Bundle

    init(bundle: Bundle, uiDevice: UIDevice) {
        self.uiDevice = uiDevice
        self.bundle = bundle
    }

    func getModel() -> String {
        return uiDevice.model
    }

    func getManufacturer() -> String {
        return "Apple"
    }

    func getOsVersion() -> String {
        return uiDevice.systemVersion
    }

    func getAppVersion() ->String? {
        return bundle.infoDictionary?["CFBundleShortVersionString"] as? String
    }

    func getCarrier() ->String {
        return ""
    }

    func getBrand() -> String {
        "Apple"
    }
}
