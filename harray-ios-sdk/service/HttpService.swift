//
//  HttpService.swift
//  harray-ios-sdk
//
//  Created by YILDIRIM ADIGÜZEL on 21.04.2020.
//  Copyright © 2020 xennio. All rights reserved.
//

import Foundation

class HttpService {

    private let collectorUrl: String

    init(collectorUrl: String) {
        self.collectorUrl = collectorUrl
    }

    func postFormUrlEncoded(payload: String)  {
        let url = URL(string: self.collectorUrl)
        if url != nil {
            var r = URLRequest(url: url!)
            r.httpMethod = "POST"
            r.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

            let d = "e=\(payload)".data(using: String.Encoding.ascii, allowLossyConversion: false)
            r.httpBody = d
            let task = URLSession.shared.dataTask(with: r) { data, response, error in
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse.statusCode)
                }
            }
            task.resume()
        }
    }

}
