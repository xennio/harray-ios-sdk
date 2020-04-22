//
//  Stubbings.swift
//  harray-ios-sdkTests
//
//  Created by YILDIRIM ADIGÜZEL on 22.04.2020.
//  Copyright © 2020 xennio. All rights reserved.
//

import Foundation

class FakeJsonSerializerService : JsonSerializerService{
    
    var expectedJsonSerializedValue: String? = "fake-json-serialized-value"
    var dictionaryCallWith : Dictionary<String,Any>?
    
    override func serialize(value: Dictionary<String, Any>) -> String?{
        if dictionaryCallWith == nil {
            return "dictionary was not expected during suite setup"
        }
        return expectedJsonSerializedValue
    }

    func givenSerializeReturns(callWith: Dictionary<String, Any>, expect: String){
           self.dictionaryCallWith = callWith
           self.expectedJsonSerializedValue = expect
    }
}

class FakeEncodingService : EncodingService {
    
    var expectedUrlEncodedValue :String? = "fake-encoded-value"
    var expectedBase64EncodedValue = "fake-base64-value"
    var base64CallWith :String?
    var urlEncodeCallWith :String?
    
    override func getUrlEncodedString(value: String) -> String? {
        if urlEncodeCallWith != value {
           return value + " was not expected during suite setup"
        }
        return expectedUrlEncodedValue
    }
    
    override func getBase64EncodedString(value: String) -> String {
        if base64CallWith != value {
                  return value + " was not expected during suite setup"
        }
        return expectedBase64EncodedValue
    }
    
    func givenBase64EncodedStringReturns(callWith: String, expect: String){
        self.base64CallWith = callWith
        self.expectedBase64EncodedValue = expect
    }
    
    func givenUrlEncodedStringReturns(callWith: String, expect: String?){
        self.urlEncodeCallWith = callWith
        self.expectedUrlEncodedValue = expect
    }
}

class FakeApplicationContextHolder : ApplicationContextHolder {
    
    override func getPersistentId() -> String {
        "fake-persistent-id"
    }
}

class FakeSessionContextHolder: SessionContextHolder {
    override func getSessionIdAndExtendSession() -> String {
        "fake-session-id"
    }
    
    override func getExternalParameters() -> Dictionary<String,Any> {
        let externalParameters: Dictionary<String, Any> = [
                "utm_soudce":"xennio"
        ]
        return externalParameters
    }
    
    override func getMemberId() -> String {
        return "fake-member-id"
    }
}

class NotInitializedUserDefaults : UserDefaults {
    
    var keyValue: String?
    var value: Any?
    
    override func string(forKey defaultName:String) -> String? {
        return nil
    }
    
    override func set(_ value: Any?, forKey defaultName: String) {
        self.keyValue = defaultName
        self.value = value
    }
    
}

class InitializedUserDefaults : UserDefaults {
    
    var value: Any?
    override func string(forKey defaultName:String) -> String? {
        return "stored-persistent-id"
    }
}
