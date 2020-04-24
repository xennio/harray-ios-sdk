//
// Created by YILDIRIM ADIGÜZEL on 22.04.2020.
// Copyright (c) 2020 xennio. All rights reserved.
//

import Foundation
import UserNotifications

public class NotificationProcessorHandler {

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

    public func savePushToken(deviceToken: String) {
        let pageViewEvent = XennEvent.create(name: "Collection", persistentId: applicationContextHolder.getPersistentId(), sessionId: sessionContextHolder.getSessionId())
                .memberId(memberId: sessionContextHolder.getMemberId())
                .addBody(key: "name", value: "pushToken")
                .addBody(key: "type", value: "iosToken")
                .addBody(key: "appType", value: "iosAppPush")
                .addBody(key: "deviceToken", value: deviceToken)
                .toMap()
        let serializedEvent = entitySerializerService.serialize(event: pageViewEvent)
        httpService.postFormUrlEncoded(payload: serializedEvent)
    }

    public func pushMessageReceived() {
        let pageViewEvent = XennEvent.create(name: "Feedback", persistentId: applicationContextHolder.getPersistentId(), sessionId: sessionContextHolder.getSessionId())
                .memberId(memberId: sessionContextHolder.getMemberId())
                .addBody(key: "type", value: "pushReceived")
                .appendExtra(params: sessionContextHolder.getExternalParameters())
                .toMap()
        let serializedEvent = entitySerializerService.serialize(event: pageViewEvent)
        httpService.postFormUrlEncoded(payload: serializedEvent)
    }

    public func pushMessageOpened() {
        let pageViewEvent = XennEvent.create(name: "Feedback", persistentId: applicationContextHolder.getPersistentId(), sessionId: sessionContextHolder.getSessionId())
                .memberId(memberId: sessionContextHolder.getMemberId())
                .addBody(key: "type", value: "pushOpened")
                .appendExtra(params: sessionContextHolder.getExternalParameters())
                .toMap()
        let serializedEvent = entitySerializerService.serialize(event: pageViewEvent)
        httpService.postFormUrlEncoded(payload: serializedEvent)
    }

    public func handlePushNotification(request: UNNotificationRequest, bestAttemptContent: UNMutableNotificationContent) {

        let source = request.content.userInfo[Constants.PUSH_PAYLOAD_SOURCE.rawValue]
        if source != nil {
            let pushChannelId = source as? String
            if Constants.PUSH_CHANNEL_ID.rawValue == pushChannelId {
                sessionContextHolder.updateExternalParameters(data: request.content.userInfo)
                pushMessageReceived()
                let imageUrl = request.content.userInfo[Constants.PUSH_PAYLOAD_IMAGE_URL.rawValue] as? String
                httpService.downloadImage(endpoint: imageUrl) { attachment in
                    if attachment != nil {
                        bestAttemptContent.attachments = [attachment!]
                    }
                }
            }
        }
    }

}