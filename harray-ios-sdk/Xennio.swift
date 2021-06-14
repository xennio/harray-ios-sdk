//
//  Xennio.swift
//  harray-ios-sdk
//
//  Created by YILDIRIM ADIGÜZEL on 21.04.2020.
//  Copyright © 2020 xennio. All rights reserved.
//

import Foundation
import UIKit

@objc public final class Xennio: NSObject {

    static var instance: Xennio?

    let sessionContextHolder: SessionContextHolder
    private let xennConfig: XennConfig
    private var pushNotificationToken: String = ""
    private let applicationContextHolder: ApplicationContextHolder
    private let eventProcessorHandler: EventProcessorHandler
    private let sdkEventProcessorHandler: SDKEventProcessorHandler
    private let notificationProcessorHandler: NotificationProcessorHandler
    private let ecommerceEventProcessorHandler: EcommerceEventProcessorHandler
    private let recommendationProcessorHandler: RecommendationProcessorHandler
    private let browsingHistoryProcessorHandler: BrowsingHistoryProcessorHandler

    private init(xennConfig: XennConfig,
                 sessionContextHolder: SessionContextHolder,
                 applicationContextHolder: ApplicationContextHolder,
                 eventProcessorHandler: EventProcessorHandler,
                 sdkEventProcessorHandler: SDKEventProcessorHandler,
                 notificationProcessorHandler: NotificationProcessorHandler,
                 ecommerceEventProcessorHandler: EcommerceEventProcessorHandler,
                 recommendationProcessorHandler: RecommendationProcessorHandler,
                 browsingHistoryProcessorHandler: BrowsingHistoryProcessorHandler) {
        self.sessionContextHolder = sessionContextHolder
        self.applicationContextHolder = applicationContextHolder
        self.eventProcessorHandler = eventProcessorHandler
        self.sdkEventProcessorHandler = sdkEventProcessorHandler
        self.notificationProcessorHandler = notificationProcessorHandler
        self.ecommerceEventProcessorHandler = ecommerceEventProcessorHandler
        self.xennConfig = xennConfig
        self.recommendationProcessorHandler = recommendationProcessorHandler
        self.browsingHistoryProcessorHandler = browsingHistoryProcessorHandler
    }
    
    @objc public class func configure(xennConfig: XennConfig) {
        let sessionContextHolder = SessionContextHolder()
        let applicationContextHolder = ApplicationContextHolder(userDefaults: UserDefaults.standard)
        let httpService = HttpService(sdkKey: xennConfig.getSdkKey(), session: URLSession.shared, collectorUrl: xennConfig.getCollectorUrl(), apiUrl: xennConfig.getApiUrl())
        let entitySerializerService = EntitySerializerService(encodingService: EncodingService(), jsonSerializerService: JsonSerializerService())
        let deviceService = DeviceService(bundle: Bundle.main, uiDevice: UIDevice.current, uiScreen: UIScreen.main, locale: Locale.current)
        
        let eventProcessorHandler = EventProcessorHandler(applicationContextHolder: applicationContextHolder, sessionContextHolder: sessionContextHolder, httpService: httpService, entitySerializerService: entitySerializerService)
        let sdkEventProcessorHandler = SDKEventProcessorHandler(applicationContextHolder: applicationContextHolder, sessionContextHolder: sessionContextHolder, httpService: httpService, entitySerializerService: entitySerializerService, deviceService: deviceService)
        let notificationProcessorHandler = NotificationProcessorHandler(httpService: httpService, entitySerializerService: entitySerializerService)
        let ecommerceEventProcessorHandler = EcommerceEventProcessorHandler(eventProcessorHandler: eventProcessorHandler)
        let jsonDeserializerService = JsonDeserializerService()
        let recommendationProcessorHandler = RecommendationProcessorHandler(applicationContextHolder: applicationContextHolder, sessionContextHolder: sessionContextHolder, httpService: httpService, sdkKey: xennConfig.getSdkKey(), jsonDeserializerService: jsonDeserializerService)
        let browsingHistoryProcessorHandler = BrowsingHistoryProcessorHandler(applicationContextHolder: applicationContextHolder, sessionContextHolder: sessionContextHolder, httpService: httpService, sdkKey: xennConfig.getSdkKey(), jsonDeserializerService: jsonDeserializerService)

        instance = Xennio(xennConfig: xennConfig,
                          sessionContextHolder: sessionContextHolder,
                          applicationContextHolder: applicationContextHolder,
                          eventProcessorHandler: eventProcessorHandler,
                          sdkEventProcessorHandler: sdkEventProcessorHandler,
                          notificationProcessorHandler: notificationProcessorHandler,
                          ecommerceEventProcessorHandler: ecommerceEventProcessorHandler,
                          recommendationProcessorHandler: recommendationProcessorHandler,
                          browsingHistoryProcessorHandler: browsingHistoryProcessorHandler
        )
    }


    class func getInstance() -> Xennio {
        return instance!
    }

    @objc public class func eventing() -> EventProcessorHandler {
        let xennioInstance = getInstance()
        let sessionContextHolder = xennioInstance.sessionContextHolder
        if (sessionContextHolder.getSessionState() != SessionState.SESSION_STARTED) {
            xennioInstance.sdkEventProcessorHandler.sessionStart()
            sessionContextHolder.startSession()
            if (xennioInstance.applicationContextHolder.isNewInstallation()){
                xennioInstance.sdkEventProcessorHandler.newInstallation()
                xennioInstance.applicationContextHolder.setInstallationCompleted()
            }
        }
        return xennioInstance.eventProcessorHandler
    }

    @objc public class func notifications() -> NotificationProcessorHandler {
        let entitySerializerService = EntitySerializerService(encodingService: EncodingService(), jsonSerializerService: JsonSerializerService())
        let httpService = HttpService(sdkKey: "feedback", session: URLSession.shared, collectorUrl: Constants.XENN_COLLECTOR_URL.rawValue,
                                      apiUrl: Constants.XENN_API_URL.rawValue)
        return NotificationProcessorHandler(httpService: httpService, entitySerializerService: entitySerializerService)
    }

    @objc public class func login(memberId: String) {
        let xennInstance = getInstance()
        let sessionContextHolder = getInstance().sessionContextHolder
        if ("" != memberId) && sessionContextHolder.getMemberId() != memberId {
            sessionContextHolder.login(memberId: memberId)
            sessionContextHolder.restartSession()
            if "" != getInstance().pushNotificationToken {
                xennInstance.eventProcessorHandler.savePushToken(deviceToken: getInstance().pushNotificationToken)
            }
        }
    }

    @objc public class func savePushToken(deviceToken: String) {
        getInstance().pushNotificationToken = deviceToken
        getInstance().eventProcessorHandler.savePushToken(deviceToken: deviceToken)
    }
    
    @objc public class func logout() {
        getInstance().eventProcessorHandler.removeTokenAssociation(deviceToken: getInstance().pushNotificationToken);
        getInstance().pushNotificationToken = ""
        getInstance().sessionContextHolder.logout()
        getInstance().sessionContextHolder.restartSession()
    }

    @objc public class func synchronizeWith(externalParameters: Dictionary<String, Any>) {
        getInstance().sessionContextHolder.updateExternalParameters(data: externalParameters)
    }

    @objc public class func ecommerce() -> EcommerceEventProcessorHandler {
        return getInstance().ecommerceEventProcessorHandler
    }
    
    @objc public class func recommendations() -> RecommendationProcessorHandler {
        return getInstance().recommendationProcessorHandler
    }

    @objc public class func browsingHistory() -> BrowsingHistoryProcessorHandler {
        return getInstance().browsingHistoryProcessorHandler
    }
}
