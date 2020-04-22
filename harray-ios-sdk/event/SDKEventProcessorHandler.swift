//
//  SDKEventProcessorHandler.swift
//  harray-ios-sdk
//
//  Created by YILDIRIM ADIGÜZEL on 22.04.2020.
//  Copyright © 2020 xennio. All rights reserved.
//

import Foundation

class SDKEventProcessorHandler {
    
    private let applicationContextHolder: ApplicationContextHolder
    private let sessionContextHolder: SessionContextHolder
    private let httpService: HttpService
    private let entitySerializerService: EntitySerializerService
    
    init(applicationContextHolder: ApplicationContextHolder, sessionContextHolder: SessionContextHolder,httpService: HttpService, entitySerializerService: EntitySerializerService) {
           self.applicationContextHolder = applicationContextHolder
           self.sessionContextHolder = sessionContextHolder
           self.httpService = httpService
           self.entitySerializerService = entitySerializerService
    }
    
    func sessionStart() {
        let pageViewEvent = XennEvent.create(name: "SS", persistentId: applicationContextHolder.getPersistentId(), sessionId: sessionContextHolder.getSessionId())
            .addHeader(key: "sv", value: applicationContextHolder.getSdkVersion())
            .memberId(memberId: sessionContextHolder.getMemberId())
            .appendExtra(params: sessionContextHolder.getExternalParameters())
            .toMap()
        let serializedEvent = entitySerializerService.serialize(event: pageViewEvent)
        if serializedEvent != nil {
            httpService.postFormUrlEncoded(payload: serializedEvent!)
        } else {
            XennioLogger.log(message: "Page View Event Error")
        }
    }
}
