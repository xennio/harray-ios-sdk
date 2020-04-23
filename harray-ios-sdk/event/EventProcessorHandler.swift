//
//  EventProcessorHandler.swift
//  harray-ios-sdk
//
//  Created by YILDIRIM ADIGÜZEL on 21.04.2020.
//  Copyright © 2020 xennio. All rights reserved.
//

import Foundation

class EventProcessorHandler {

    private let applicationContextHolder: ApplicationContextHolder
    private let sessionContextHolder: SessionContextHolder
    private let httpService: HttpService
    private let entitySerializerService: EntitySerializerService

    init(applicationContextHolder: ApplicationContextHolder, sessionContextHolder: SessionContextHolder, httpService: HttpService, entitySerializerService: EntitySerializerService) {
        self.applicationContextHolder = applicationContextHolder
        self.sessionContextHolder = sessionContextHolder
        self.httpService = httpService
        self.entitySerializerService = entitySerializerService
    }

    func pageView(pageType: String) {
        pageView(pageType: pageType, params: Dictionary<String, Any>())
    }

    func pageView(pageType: String, params: Dictionary<String, Any>) {
        let pageViewEvent = XennEvent.create(name: "PV", persistentId: applicationContextHolder.getPersistentId(), sessionId: sessionContextHolder.getSessionId())
                .addBody(key: "pageType", value: pageType)
                .memberId(memberId: sessionContextHolder.getMemberId())
                .appendExtra(params: params)
                .appendExtra(params: sessionContextHolder.getExternalParameters())
                .toMap()
        let serializedEvent = entitySerializerService.serialize(event: pageViewEvent)
        httpService.postFormUrlEncoded(payload: serializedEvent)
    }

    func actionResult(type: String) {
        actionResult(type: type, params: Dictionary<String, Any>())
    }

    func actionResult(type: String, params: Dictionary<String, Any>) {
        let pageViewEvent = XennEvent.create(name: "AR", persistentId: applicationContextHolder.getPersistentId(), sessionId: sessionContextHolder.getSessionId())
                .addBody(key: "type", value: type)
                .memberId(memberId: sessionContextHolder.getMemberId())
                .appendExtra(params: params)
                .toMap()
        let serializedEvent = entitySerializerService.serialize(event: pageViewEvent)
        httpService.postFormUrlEncoded(payload: serializedEvent)
    }

    func impression(pageType: String) {
        impression(pageType: pageType, params: Dictionary<String, Any>())
    }

    func impression(pageType: String, params: Dictionary<String, Any>) {
        let pageViewEvent = XennEvent.create(name: "IM", persistentId: applicationContextHolder.getPersistentId(), sessionId: sessionContextHolder.getSessionId())
                .addBody(key: "pageType", value: pageType)
                .memberId(memberId: sessionContextHolder.getMemberId())
                .appendExtra(params: params)
                .toMap()
        let serializedEvent = entitySerializerService.serialize(event: pageViewEvent)
        httpService.postFormUrlEncoded(payload: serializedEvent)
    }

    func custom(eventName: String, params: Dictionary<String, Any>) {
        let pageViewEvent = XennEvent.create(name: eventName, persistentId: applicationContextHolder.getPersistentId(), sessionId: sessionContextHolder.getSessionId())
                .memberId(memberId: sessionContextHolder.getMemberId())
                .appendExtra(params: params)
                .toMap()
        let serializedEvent = entitySerializerService.serialize(event: pageViewEvent)
        httpService.postFormUrlEncoded(payload: serializedEvent)
    }
}
