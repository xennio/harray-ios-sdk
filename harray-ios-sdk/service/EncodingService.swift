//
//  EncodingService.swift
//  harray-ios-sdk
//
//  Created by YILDIRIM ADIGÜZEL on 21.04.2020.
//  Copyright © 2020 xennio. All rights reserved.
//

import Foundation

class EncodingService {
    
    func getUrlEncodedString(value: String) -> String? {
        return value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
    
    func getBase64EncodedString(value: String) -> String {
        return Data(value.utf8).base64EncodedString()
    }
    
}
