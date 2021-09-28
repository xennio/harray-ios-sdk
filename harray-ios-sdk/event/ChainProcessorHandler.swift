//
//  ChainProcessorHandler.swift
//  harray-ios-sdk
//
//  Created by Yildirim Adiguzel on 28.09.2021.
//  Copyright © 2021 xennio. All rights reserved.
//

import Foundation

public class ChainProcessorHandler {
    var handlers: Array<AfterPageViewEventHandler> = []
    
    func addHandler(handler: AfterPageViewEventHandler) {
        self.handlers.append(handler)
    }
    
    func callAll(pageType: String){
        for eachHandler in handlers {
            eachHandler.callAfter(pageType: pageType)
        }
    }
}
