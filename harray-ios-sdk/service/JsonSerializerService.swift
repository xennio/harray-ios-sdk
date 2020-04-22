//
//  JsonSerializerService.swift
//  harray-ios-sdk
//
//  Created by YILDIRIM ADIGÜZEL on 21.04.2020.
//  Copyright © 2020 xennio. All rights reserved.
//

import Foundation

class JsonSerializerService {
    func serialize(value: Dictionary<String, Any>) -> String? {
        let jsonSerialzed = try? JSONSerialization.data(withJSONObject: value, options: [])
        if jsonSerialzed != nil{
            return String(data: jsonSerialzed!, encoding: .utf8)
        }
        return nil
    }
}
