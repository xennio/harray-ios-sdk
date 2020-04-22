//
//  EntitySerializerServiceTest.swift
//  harray-ios-sdkTests
//
//  Created by YILDIRIM ADIGÜZEL on 21.04.2020.
//  Copyright © 2020 xennio. All rights reserved.
//

import XCTest

class EntitySerializerServiceTest: XCTestCase {
    
    var encodingService = FakeEncodingService()
    var jsonSerializerService = FakeJsonSerializerService()
    

    func test_it_should_convert_entity_to_base_64_url_encoded_string(){
        let event = Dictionary<String,Any>()
        let entitySerializerService = EntitySerializerService(encodingService: encodingService,jsonSerializerService: jsonSerializerService)
        
        jsonSerializerService.givenSerializeReturns(callWith: event, expect: "JSONVALUE")
        encodingService.givenUrlEncodedStringReturns(callWith: "JSONVALUE", expect: "URLENCODEDVALUE")
        encodingService.givenUrlEncodedStringReturns(callWith:"URLENCODEDVALUE", expect:" BASE64STRINGVALUE")
        let serializedEntity = entitySerializerService.serialize(event:event)
        
        XCTAssertEqual("BASE64STRINGVALUE", serializedEntity)
    }
    
}
