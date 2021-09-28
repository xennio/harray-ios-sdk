//
//  InAppNotificationProcessorHandler.swift
//  harray-ios-sdk
//
//  Created by Yildirim Adiguzel on 28.09.2021.
//  Copyright © 2021 xennio. All rights reserved.
//

import Foundation
import UIKit

@objc public class InAppNotificationProcessorHandler: NSObject, AfterPageViewEventHandler {
    
    private let xennConfig: XennConfig
    private let applicationContextHolder: ApplicationContextHolder
    private let sessionContextHolder: SessionContextHolder
    private let httpService: HttpService
    private let eventProcessorHandler: EventProcessorHandler
    private let jsonDeserializerService: JsonDeserializerService
    
    init(applicationContextHolder: ApplicationContextHolder, sessionContextHolder: SessionContextHolder, httpService: HttpService, eventProcessorHandler: EventProcessorHandler, xennConfig: XennConfig,jsonDeserializerService: JsonDeserializerService) {
        self.applicationContextHolder = applicationContextHolder
        self.sessionContextHolder = sessionContextHolder
        self.httpService = httpService
        self.eventProcessorHandler = eventProcessorHandler
    
        self.xennConfig = xennConfig
        self.jsonDeserializerService = jsonDeserializerService
    }

    
    func showPopup(data: InAppNotificationResponse?){
        if let notificationResponse = data {
            var params = Dictionary<String, String>()
            params["entity"] = "banners"
            params["id"] = notificationResponse.id
            eventProcessorHandler.impression(pageType: "bannerShow", params: params)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                
                if let frame = self.topViewController()?.view.frame {
                    let mView = InAppView(frame: frame)
                    mView.loadPopup(content: "<html><head>" + notificationResponse.style + "</head><body>" + notificationResponse.html + "</body></html>")
                    mView.onNavigation = {
                        navigateTo in
                        self.xennConfig.getInAppNotificationLinkClickHandler()?(navigateTo)
                    }
                    mView.onClose = {
                        params["action"] = "close"
                        self.eventProcessorHandler.impression(pageType: "bannerClose", params: params)
                    }
                    self.topViewController()?.view.addSubview(mView)
                }
            }
        }
        
    }
    
    
    func callAfter(pageType: String) {
        var params = Dictionary<String, String>()
        params["sdkKey"] = xennConfig.getSdkKey()
        params["pid"] = applicationContextHolder.getPersistentId()
        params["pageType"] = pageType
        if sessionContextHolder.getMemberId() != nil {
            params["memberId"] = sessionContextHolder.getMemberId()
        }

        let responseHandler: (HttpResult) -> InAppNotificationResponse? = { hr in
            if let body = hr.getBody() {
                return self.jsonDeserializerService.deserialize(jsonString: body)
            } else {
                return nil
            }
        }
        
        let callback: (InAppNotificationResponse?) -> Void = {data in
            self.showPopup(data: data)
        }

        
        httpService.getApiRequest(
                path: "/in-app-notifications",
                params: params,
                responseHandler: responseHandler,
                completionHandler: callback)
        
    }
   
    
    func topViewController() -> UIViewController? {
        guard let window = UIApplication.shared.keyWindow, let rootViewController = window.rootViewController else {
            return nil
        }

        var topViewController = rootViewController

        while let newTopViewController = topViewController.presentedViewController {
            topViewController = newTopViewController
        }

        return topViewController
    }
    
    
}


