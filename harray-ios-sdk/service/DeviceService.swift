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
    let locale: Locale

    init(bundle: Bundle, uiDevice: UIDevice, uiScreen: UIScreen, locale: Locale) {
        self.uiDevice = uiDevice
        self.bundle = bundle
        self.uiScreen = uiScreen
        self.locale = locale
    }
    
    func getLanguage() -> String {
        return locale.languageCode ?? "en"
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

    func getDeviceModel() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
}
