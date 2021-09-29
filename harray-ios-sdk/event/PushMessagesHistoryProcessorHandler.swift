//
//  PushMessagesHistoryProcessorHandler.swift
//  harray-ios-sdk
//
//  Created by Bay Batu on 29.09.2021.
//  Copyright © 2021 xennio. All rights reserved.
//

import Foundation

@objc public class PushMessagesHistoryProcessorHandler: NSObject {
    
    private let sessionContextHolder: SessionContextHolder
    private let httpService: HttpService
    private let sdkKey: String
    private let jsonDeserializerService: JsonDeserializerService
    
    init(sessionContextHolder: SessionContextHolder,
         httpService: HttpService,
         sdkKey: String,
         jsonDeserializerService: JsonDeserializerService
    ) {
        self.sessionContextHolder = sessionContextHolder
        self.httpService = httpService
        self.sdkKey = sdkKey
        self.jsonDeserializerService = jsonDeserializerService
    }
    
    public func getPushMessagesHistory(size: Int8,
                                       callback: @escaping (Array<Dictionary<String, String>>?) -> Void) -> Void {
        guard sessionContextHolder.getMemberId() != nil else {
            preconditionFailure("memberId cannot be nil for push messages history. Use Xennio.login(memberId) method first.")
        }
        var params = Dictionary<String, String>()
        params["sdkKey"] = sdkKey
        params["memberId"] = sessionContextHolder.getMemberId()
        params["size"] = String(size)
        let responseHandler: (HttpResult) -> Array<Dictionary<String, String>>? = { hr in
            if let body = hr.getBody() {
                return self.jsonDeserializerService.deserializeToDictArray(jsonString: body)
            } else {
                return nil
            }
        }
        httpService.getApiRequest(
                path: "/push-messages-history",
                params: params,
                responseHandler: responseHandler,
                completionHandler: callback)
    }
}
