//
//  EntitySerializerServiceTest.swift
//  harray-ios-sdkTests
//
//  Created by YILDIRIM ADIGÜZEL on 21.04.2020.
//  Copyright © 2020 xennio. All rights reserved.
//

import XCTest

class EntitySerializerServiceTest: XCTestCase {
    
    func test_it_should_convert_entity_to_base_64_url_encoded_string(){
        let encodingService = FakeEncodingService()
        let jsonSerializerService = FakeJsonSerializerService()
        
        let event = Dictionary<String,Any>()
        let entitySerializerService = EntitySerializerService(encodingService: encodingService,jsonSerializerService: jsonSerializerService)
        
        jsonSerializerService.givenSerializeReturns(callWith: event, expect: "JSONVALUE")
        encodingService.givenUrlEncodedStringReturns(callWith: "JSONVALUE", expect: "URLENCODEDVALUE")
        encodingService.givenBase64EncodedStringReturns(callWith:"URLENCODEDVALUE", expect:"BASE64STRINGVALUE")
       
        let serializedEntity = entitySerializerService.serializeToBase64(event:event)
        
        XCTAssertEqual("BASE64STRINGVALUE", serializedEntity!)
    }
    
    func test_it_should_return_nil_entity_when_event_not_serializable(){
        let encodingService = FakeEncodingService()
        let jsonSerializerService = FakeJsonSerializerService()
        
        let event = Dictionary<String,Any>()
        let entitySerializerService = EntitySerializerService(encodingService: encodingService,jsonSerializerService: jsonSerializerService)
        
        jsonSerializerService.givenSerializeReturns(callWith: event, expect: nil)
    
       
        let serializedEntity = entitySerializerService.serializeToBase64(event:event)
        
        XCTAssertNil(serializedEntity)
    }
    
    func test_it_should_return_nil_entity_when_event_serializable_but_not_sutiable_for_url_encode(){
        let encodingService = FakeEncodingService()
        let jsonSerializerService = FakeJsonSerializerService()
        
        let event = Dictionary<String,Any>()
        let entitySerializerService = EntitySerializerService(encodingService: encodingService,jsonSerializerService: jsonSerializerService)
        
        jsonSerializerService.givenSerializeReturns(callWith: event, expect: "JSONVALUE")
               encodingService.givenUrlEncodedStringReturns(callWith: "JSONVALUE", expect: nil)
    
       
        let serializedEntity = entitySerializerService.serializeToBase64(event:event)
        
        XCTAssertNil(serializedEntity)
    }
    
}
