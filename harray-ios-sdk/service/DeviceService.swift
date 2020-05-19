//
//  DeviceService.swift
//  harray-ios-sdk
//
//  Created by YILDIRIM ADIGÜZEL on 22.04.2020.
//  Copyright © 2020 xennio. All rights reserved.
//

import Foundation
import UIKit
import CoreTelephony

class DeviceService {

    let uiDevice: UIDevice
    let bundle: Bundle
    let uiScreen: UIScreen

    init(bundle: Bundle, uiDevice: UIDevice, uiScreen: UIScreen) {
        self.uiDevice = uiDevice
        self.bundle = bundle
        self.uiScreen = uiScreen
    }

    func getModel() -> String {
        return uiDevice.model
    }

    func getManufacturer() -> String {
        return Constants.APPLE.rawValue
    }

    func getOsVersion() -> String {
        return uiDevice.systemVersion
    }

    func getAppVersion() -> String {
        return bundle.infoDictionary?["CFBundleShortVersionString"] as? String ?? Constants.UNKNOWN_PROPERTY_VALUE.rawValue
    }

    func getAppName() -> String {
        return bundle.infoDictionary?["CFBundleName"] as? String ?? Constants.UNKNOWN_PROPERTY_VALUE.rawValue
    }
    
    func getScreenWidth() -> CGFloat {
        return uiScreen.bounds.size.width
    }
    
    func getScreenHeight() -> CGFloat {
        return uiScreen.bounds.size.height
    }

    func getCarrier() -> String {
        let info = CTTelephonyNetworkInfo()
        let carrier = info.subscriberCellularProvider
        return carrier?.carrierName ?? Constants.UNKNOWN_PROPERTY_VALUE.rawValue
    }

    func getBrand() -> String {
        return Constants.APPLE.rawValue
    }
}
