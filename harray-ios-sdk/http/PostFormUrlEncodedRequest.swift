//
// Created by YILDIRIM ADIGÜZEL on 26.04.2020.
// Copyright (c) 2020 xennio. All rights reserved.
//

import Foundation

class PostFormUrlEncodedRequest: HttpTask {
    private let payload: String
    private let url: URL

    init(payload: String, endpoint: String) {
        self.url = URL(string: endpoint)!
        self.payload = payload
    }

    func getUrlRequest() -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let body = "e=\(payload)".data(using: String.Encoding.ascii, allowLossyConversion: false)
        request.httpBody = body
        return request
    }
}
