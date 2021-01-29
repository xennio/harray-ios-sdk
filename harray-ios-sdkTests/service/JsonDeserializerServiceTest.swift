//
//  JsonDeserializerServiceTest.swift
//  harray-ios-sdkTests
//
//  Created by Bay Batu on 29.01.2021.
//  Copyright © 2021 xennio. All rights reserved.
//

import XCTest

class JsonDeserializerServiceTest: XCTestCase {
    
    func it_should_convert_string_json_to_specified_object_type() {
        
        struct MyStruct: Decodable {
            let id: String
            let name: String
            let age: Int
        }

        let jsonDeserializerService = JsonDeserializerService()
        
        let jsonStr: String = """
            [
                { "id": "id1", "name": "name1", "age": 12 },
                { "id": "id2", "name": "name2", "age": 22 }
            ]
        """
        
        let result: Array<MyStruct>? = jsonDeserializerService.deserialize(jsonString: jsonStr)
        
        XCTAssertEqual(result?.count, 2)
        XCTAssertEqual(result?[0].id, "id1")
        XCTAssertEqual(result?[0].name, "name1")
        XCTAssertEqual(result?[0].age, 12)
        XCTAssertEqual(result?[1].id, "id2")
        XCTAssertEqual(result?[1].name, "name2")
        XCTAssertEqual(result?[1].age, 22)
    }
    
    func it_should_convert_string_json_to_array_of_dict() {
        let jsonDeserializerService = JsonDeserializerService()
        
        let jsonStr: String = """
            [
                { "id": "id1", "name": "name1", "age": 12 },
                { "id": "id2", "name": "name2", "age": 22 }
            ]
        """
        
        let result = jsonDeserializerService.deserializeToDictArray(jsonString: jsonStr)
        
        XCTAssertEqual(result?.count, 2)
        XCTAssertEqual(result?[0]["id"], "id1")
        XCTAssertEqual(result?[0]["name"], "name1")
        XCTAssertEqual(result?[0]["age"], "12")
        XCTAssertEqual(result?[1]["id"], "id2")
        XCTAssertEqual(result?[1]["name"], "name2")
        XCTAssertEqual(result?[1]["age"], "22")
    }
}

