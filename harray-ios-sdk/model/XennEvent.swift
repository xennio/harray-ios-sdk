//
//  XennEvent.swift
//  harray-ios-sdk
//
//  Created by YILDIRIM ADIGÜZEL on 21.04.2020.
//  Copyright © 2020 xennio. All rights reserved.
//

import Foundation

class XennEvent{
    
    private var h : Dictionary<String, Any> = Dictionary<String, Any>()
    private var b : Dictionary<String, Any> = Dictionary<String, Any>()
    
    class func create(name:String, persistentId: String, sessionId: String) -> XennEvent {
        let xennEvent = XennEvent()
        xennEvent.h["n"] = name
        xennEvent.h["p"] = persistentId
        xennEvent.h["s"] = sessionId
        return xennEvent
    }
    
    func addHeader(key:String, value: Any) -> XennEvent {
        h[key] = value
        return self
    }
    
    func addBody(key:String, value: Any) -> XennEvent {
        b[key] = value
        return self
    }
    
    func memberId(memberId: String?) -> XennEvent {
        if memberId != nil{
            if memberId != "" {
                return addBody(key: "memberId", value: memberId!)
            }
        }
        return self
    }
    
    func appendExtra(params: Dictionary<String, Any>) -> XennEvent {
        for eachParam in params {
            b[eachParam.key] = eachParam.value
        }
        return self
    }
    
    func toMap() -> Dictionary<String, Any> {
        var map = Dictionary<String,Any>()
        map["h"] = h
        map["b"] = b
        return map
    }
    
}
