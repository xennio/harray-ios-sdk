//
// Created by Yildirim Adiguzel on 3.05.2020.
// Copyright (c) 2020 xennio. All rights reserved.
//

import Foundation

class PostJsonEncodedRequest: HttpTask {

    private let payload: String
    private let url: URL

    init(payload: String, endpoint: String) {
        self.url = URL(string: endpoint)!
        self.payload = payload
    }

    func getUrlRequest() -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = payload.data(using: String.Encoding.utf8, allowLossyConversion: false)
        request.httpBody = body
        return request
    }
}
