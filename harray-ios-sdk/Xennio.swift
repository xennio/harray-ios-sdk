//
//  Xennio.swift
//  harray-ios-sdk
//
//  Created by YILDIRIM ADIGÜZEL on 21.04.2020.
//  Copyright © 2020 xennio. All rights reserved.
//

import Foundation
import UIKit

public class Xennio: Equatable {

    static var instance: Xennio?

    let sessionContextHolder: SessionContextHolder
    private let applicationContextHolder: ApplicationContextHolder
    private let eventProcessorHandler: EventProcessorHandler
    private let sdkEventProcessorHandler: SDKEventProcessorHandler
    private let hashValue: String = RandomValueUtils.randomUUID()

    private init(sdkKey: String,
                 sessionContextHolder: SessionContextHolder,
                 applicationContextHolder: ApplicationContextHolder,
                 eventProcessorHandler: EventProcessorHandler,
                 sdkEventProcessorHandler: SDKEventProcessorHandler) {
        self.sessionContextHolder = sessionContextHolder
        self.applicationContextHolder = applicationContextHolder
        self.eventProcessorHandler = eventProcessorHandler
        self.sdkEventProcessorHandler = sdkEventProcessorHandler
    }

    public class func configure(sdkKey: String) {
        let sessionContextHolder = SessionContextHolder()
        let applicationContextHolder = ApplicationContextHolder(userDefaults: UserDefaults.standard, sdkKey: sdkKey)
        let httpService = HttpService(collectorUrl: applicationContextHolder.getCollectorUrl())
        let entitySerializerService = EntitySerializerService(encodingService: EncodingService(), jsonSerializerService: JsonSerializerService())
        let deviceService = DeviceService(bundle: Bundle.main, uiDevice: UIDevice.current)

        let eventProcessorHandler = EventProcessorHandler(applicationContextHolder: applicationContextHolder, sessionContextHolder: sessionContextHolder, httpService: httpService, entitySerializerService: entitySerializerService)
        let sdkEventProcessorHandler = SDKEventProcessorHandler(applicationContextHolder: applicationContextHolder, sessionContextHolder: sessionContextHolder, httpService: httpService, entitySerializerService: entitySerializerService, deviceService: deviceService)

        instance = Xennio(sdkKey: sdkKey,
                sessionContextHolder: sessionContextHolder,
                applicationContextHolder: applicationContextHolder,
                eventProcessorHandler: eventProcessorHandler,
                sdkEventProcessorHandler: sdkEventProcessorHandler
        )
    }

    class func getInstance() throws -> Xennio {
        if instance == nil {
            throw XennError.configuration(message: "Xennio.configure(sdkKey: sdkKey) must be called before getting instance")
        }
        return instance!
    }

    public class func eventing() throws -> EventProcessorHandler {
        let xennioInstance = try getInstance()
        let sessionContextHolder = xennioInstance.sessionContextHolder
        if (sessionContextHolder.getSessionState() != SessionState.SESSION_STARTED) {
            xennioInstance.sdkEventProcessorHandler.sessionStart()
            sessionContextHolder.startSession()
        }
        return xennioInstance.eventProcessorHandler
    }

    public class func login(memberId: String) throws {
        let xennioInstance = try getInstance()
        xennioInstance.sessionContextHolder.login(memberId: memberId)
    }

    public class func logout() throws {
        let xennioInstance = try getInstance()
        xennioInstance.sessionContextHolder.logout()
    }

    public static func ==(lhs: Xennio, rhs: Xennio) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
