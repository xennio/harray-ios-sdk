//
//  BrowsingHistoryProcessorHandler.swift
//  harray-ios-sdk
//
//  Created by Bay Batu on 14.06.2021.
//  Copyright © 2021 xennio. All rights reserved.
//

import Foundation

@objc public class BrowsingHistoryProcessorHandler: NSObject {

    private let applicationContextHolder: ApplicationContextHolder
    private let sessionContextHolder: SessionContextHolder
    private let httpService: HttpService
    private let sdkKey: String
    private let jsonDeserializerService: JsonDeserializerService

    init(applicationContextHolder: ApplicationContextHolder,
         sessionContextHolder: SessionContextHolder,
         httpService: HttpService,
         sdkKey: String,
         jsonDeserializerService: JsonDeserializerService
    ) {
        self.applicationContextHolder = applicationContextHolder
        self.sessionContextHolder = sessionContextHolder
        self.httpService = httpService
        self.sdkKey = sdkKey
        self.jsonDeserializerService = jsonDeserializerService
    }

    public func getBrowsingHistory(entityName: String,
                                   size: Int8,
                                   callback: @escaping (Array<Dictionary<String, String>>?) -> Void) -> Void {
        var params = Dictionary<String, String>()
        params["sdkKey"] = sdkKey
        params["pid"] = applicationContextHolder.getPersistentId()
        params["entityName"] = entityName
        if sessionContextHolder.getMemberId() != nil {
            params["memberId"] = sessionContextHolder.getMemberId()
        }
        params["size"] = String(size)
        let responseHandler: (HttpResult) -> Array<Dictionary<String, String>>? = { hr in
            if let body = hr.getBody() {
                return self.jsonDeserializerService.deserializeToDictArray(jsonString: body)
            } else {
                return nil
            }
        }
        httpService.getApiRequest(
                path: "/browsing-history",
                params: params,
                responseHandler: responseHandler,
                completionHandler: callback)
    }

}
