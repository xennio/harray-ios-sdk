//
//  RecommendationProcessorHandler.swift
//  harray-ios-sdk
//
//  Created by Bay Batu on 27.01.2021.
//  Copyright © 2021 xennio. All rights reserved.
//

import Foundation

@objc public class RecommendationProcessorHandler: NSObject {
    
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
    
    public func getRecommendations(boxId: String,
                                   entityId: String?,
                                   size: Int8,
                                   callback: @escaping ([[String: String]]?) -> Void) -> Void {
        var params = Dictionary<String, String>()
        params["sdkKey"] = sdkKey
        params["pid"] = applicationContextHolder.getPersistentId()
        params["boxId"] = boxId
        if sessionContextHolder.getMemberId() != nil {
            params["memberId"] = sessionContextHolder.getMemberId()
        }
        if entityId != nil {
            params["entityId"] = entityId
        }
        params["size"] = String(size)
        let responseHandler: (HttpResult) -> [[String: String]]? = { hr in
            if let body = hr.getBody() {
                return self.jsonDeserializerService.deserializeToDictArray(jsonString: body)
            } else {
                XennioLogger.log(message: "Empty recommendation json response")
                return nil
            }
        }
        httpService.getApiRequest(
            path: "/recommendation",
            params: params,
            responseHandler: responseHandler,
            completionHandler: callback)
    }
    
}
