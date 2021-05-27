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
    private var apiUrl: String = Constants.XENN_API_URL.rawValue
    private var collectorUrl: String = Constants.XENN_COLLECTOR_URL.rawValue
    
    private init(sdkKey: String) {
        self.sdkKey = sdkKey
    }
    
    public static func create(sdkKey: String) -> XennConfig {
        return XennConfig(sdkKey: sdkKey)
    }
    
    public func collectorUrl(url: String) -> XennConfig {
        self.collectorUrl = XennConfig.getValidUrl(url: url)
        return self
    }

    public func apiUrl(url: String) -> XennConfig {
        self.apiUrl = XennConfig.getValidUrl(url: url)
        return self
    }

    public func getSdkKey() -> String {
        return self.sdkKey
    }

    public func getCollectorUrl() -> String {
        return self.collectorUrl
    }

    public func getApiUrl() -> String {
        return self.apiUrl
    }
    
    private static func getValidUrl(url: String) -> String {
        return UrlUtils.removeTrailingSlash(url: url)
    }
}
