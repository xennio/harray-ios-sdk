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
    private let session: HttpSession

    init(collectorUrl: String, session: HttpSession) {
        self.collectorUrl = collectorUrl
        self.session = session
    }

    func postFormUrlEncoded(payload: String?) {
        postFormUrlEncoded(payload: payload) { httpResult in
            if httpResult.isSuccess() {
                XennioLogger.log(message: "Xenn collector returned \(httpResult.getStatusCode())")
            } else {
                // TO-DO: Retry logic and more error handling
            }
        }
    }

    func postFormUrlEncoded(payload: String?, completionHandler: @escaping (HttpResult) -> Void) {
        if payload != nil {
            let postFromUrlEncodedRequest = PostFormUrlEncodedRequest(payload: payload!, endpoint: collectorUrl)
            let request = postFromUrlEncodedRequest.getUrlRequest()
            session.doRequest(from: request) { httpResult in
                completionHandler(httpResult)
            }
        } else {
            completionHandler(HttpResult.clientError())
        }

    }

    func downloadContent(endpoint: String?, with completionHandler: @escaping (HttpDownloadableResult?) -> Void) {
        session.downloadTask(with: endpoint) { result in
            if result != nil {
                completionHandler(HttpDownloadableResult(path: result!.getPath()))
            } else {
                completionHandler(nil)
            }
        }
    }

}
