//
//  XennConfig.swift
//  harray-ios-sdk
//
//  Created by Bay Batu on 20.04.2021.
//  Copyright © 2021 xennio. All rights reserved.
//

import Foundation

@objc public class XennConfig: NSObject {

    private let sdkKey: String
    private let collectorUrl: String
    private var apiUrl: String = Constants.XENN_API_URL.rawValue

    private init(sdkKey: String, collectorUrl: String) {
        self.sdkKey = sdkKey
        self.collectorUrl = collectorUrl
    }

    public static func create(sdkKey: String, collectorUrl: String) -> XennConfig {
        return XennConfig(sdkKey: sdkKey, collectorUrl: getValidUrl(url: collectorUrl))
    }

    public func apiUrl(url: String) -> XennConfig {
        self.apiUrl = XennConfig.getValidUrl(url: url)
        return self
    }

    public func getSdkKey() -> String {
        return sdkKey
    }

    public func getCollectorUrl() -> String {
        return collectorUrl
    }

    public func getApiUrl() -> String {
        return apiUrl
    }

    private static func getValidUrl(url: String) -> String {
        return UrlUtils.removeTrailingSlash(url: url)
    }
}
