//
//  ApiGetJsonRequest.swift
//  harray-ios-sdk
//
//  Created by Bay Batu on 27.01.2021.
//  Copyright © 2021 xennio. All rights reserved.
//

import Foundation

class ApiGetJsonRequest: HttpTask {
    
    private let url: URL
    
    init(endpoint: String) {
        self.url = URL(string: endpoint)!
    }
    
    func getUrlRequest() -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}
