//
// Created by YILDIRIM ADIGÜZEL on 22.04.2020.
// Copyright (c) 2020 xennio. All rights reserved.
//

import Foundation
import UserNotifications

public class NotificationProcessorHandler {

    private let httpService: HttpService
    private let entitySerializerService: EntitySerializerService

    init( httpService: HttpService, entitySerializerService: EntitySerializerService) {
        self.httpService = httpService
        self.entitySerializerService = entitySerializerService
    }

    func pushMessageReceived(pushContent: Dictionary<AnyHashable, Any>) {
        let pushId = getContentItem(key: Constants.PUSH_ID_KEY.rawValue, pushContent: pushContent)
        let pageViewEvent = XennEvent.create(name: "Feedback")
                .addBody(key: "type", value: "pushReceived")
                .addBody(key: "id", value: pushId)
                .toMap()
        let serializedEvent = entitySerializerService.serialize(event: pageViewEvent)
        httpService.postFormUrlEncoded(payload: serializedEvent)
    }

    public func pushMessageOpened(pushContent: Dictionary<AnyHashable, Any>) {
        let pushId = getContentItem(key: Constants.PUSH_ID_KEY.rawValue, pushContent: pushContent)
        let pageViewEvent = XennEvent.create(name: "Feedback")
                .addBody(key: "type", value: "pushOpened")
                .addBody(key: "id", value: pushId)
                .toMap()
        let serializedEvent = entitySerializerService.serialize(event: pageViewEvent)
        httpService.postFormUrlEncoded(payload: serializedEvent)
    }

    public func handlePushNotification(request: UNNotificationRequest,
                                       bestAttemptContent: UNMutableNotificationContent,
                                       withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {

        let source = request.content.userInfo[Constants.PUSH_PAYLOAD_SOURCE.rawValue]
        if source != nil {
            let pushChannelId = source as? String
            if Constants.PUSH_CHANNEL_ID.rawValue == pushChannelId! {
                pushMessageReceived(pushContent: request.content.userInfo)
                let imageUrl = request.content.userInfo[Constants.PUSH_PAYLOAD_IMAGE_URL.rawValue] as? String
                if imageUrl != nil {
                    httpService.downloadContent(endpoint: imageUrl) { response in
                        if response != nil {
                            do {
                                let imageAttachment = try UNNotificationAttachment(identifier: "picture", url: response!.getPath(), options: nil)
                                bestAttemptContent.attachments = [imageAttachment]
                                contentHandler(bestAttemptContent)
                            } catch {
                                contentHandler(bestAttemptContent)
                                XennioLogger.log(message: "unable to handle push notification image")
                            }
                        }
                    }
                } else {
                    contentHandler(bestAttemptContent)
                }
            }
        }
    }

    private func getContentItem(key: String, pushContent: Dictionary<AnyHashable, Any>) -> String? {
        return pushContent[key] as? String

    }
}