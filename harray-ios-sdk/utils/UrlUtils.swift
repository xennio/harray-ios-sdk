//
//  UrlUtils.swift
//  harray-ios-sdk
//
//  Created by Bay Batu on 21.04.2021.
//  Copyright © 2021 xennio. All rights reserved.
//

import Foundation

class UrlUtils {

    private init() {

    }

    static func removeTrailingSlash(url: String) -> String {
        if (url.hasSuffix("/")) {
            let index = url.lastIndex(of: "/")!
            return String(url.prefix(upTo: index))
        }
        return url
    }
}
