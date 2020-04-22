//
//  Xennio.swift
//  harray-ios-sdk
//
//  Created by YILDIRIM ADIGÜZEL on 21.04.2020.
//  Copyright © 2020 xennio. All rights reserved.
//

import Foundation

class Xennio{
    
    private let sessionContextHolder : SessionContextHolder
    private let eventProcessorHandler: EventProcessorHandler

    
    init(sdkKey: String){
        self.sessionContextHolder = SessionContextHolder()
        let applicationContextHolder = ApplicationContextHolder(userDefaults: UserDefaults.standard, sdkKey: sdkKey)
        let httpService = HttpService(collectorUrl: applicationContextHolder.getCollectorUrl())
        let entitySerializerService = EntitySerializerService(encodingService: EncodingService(), jsonSerializerService: JsonSerializerService())
        self.eventProcessorHandler = EventProcessorHandler(applicationContextHolder: applicationContextHolder, sessionContextHolder: self.sessionContextHolder,httpService: httpService, entitySerializerService: entitySerializerService)
    }
}
