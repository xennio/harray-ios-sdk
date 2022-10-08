//
//  MemberSummaryProcessorHandler.swift
//  harray-ios-sdk
//
//  Created by YILDIRIM ADIGÜZEL on 10/3/22.
//  Copyright © 2022 xennio. All rights reserved.
//

import Foundation

@available(iOSApplicationExtension,unavailable)
@objc public class MemberSummaryProcessorHandler: NSObject {
    
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
    
    public func getDetails(summaryConfigId: String,
                           callback: @escaping (MemberSummary?) -> Void) -> Void {
        var params = Dictionary<String, String>()
        params["sdkKey"] = sdkKey
        params["pid"] = applicationContextHolder.getPersistentId()
        params["boxId"] = summaryConfigId
        if sessionContextHolder.getMemberId() != nil {
            params["memberId"] = sessionContextHolder.getMemberId()
        }
        params["size"] = "1"
        let responseHandler: (HttpResult) -> MemberSummary? = { hr in
            if let body = hr.getBody() {
                return self.jsonDeserializerService.deserialize(jsonString: body)
            } else {
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
