//
//  HttpService.swift
//  harray-ios-sdk
//
//  Created by YILDIRIM ADIGÜZEL on 21.04.2020.
//  Copyright © 2020 xennio. All rights reserved.
//

import Foundation

class HttpService {

    private let sdkKey: String
    private let session: HttpSession
    private let collectorUrl: String
    private let apiUrl: String

    init(sdkKey: String, session: HttpSession, collectorUrl: String, apiUrl: String) {
        self.session = session
        self.sdkKey = sdkKey
        self.collectorUrl = collectorUrl
        self.apiUrl = apiUrl
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

    func postJsonEncoded(payload: String?, path: String) {
        postJsonEncoded(payload: payload, path: path) { httpResult in
            if httpResult.isSuccess() {
                XennioLogger.log(message: "Xenn path returned \(httpResult.getStatusCode())")
            } else {
                // TO-DO: Retry logic and more error handling
            }
        }
    }

    func postFormUrlEncoded(payload: String?, completionHandler: @escaping (HttpResult) -> Void) {
        if payload != nil {
            let postFromUrlEncodedRequest = PostFormUrlEncodedRequest(payload: payload!, endpoint: getCollectorUrl())
            let request = postFromUrlEncodedRequest.getUrlRequest()
            session.doRequest(from: request) { httpResult in
                completionHandler(httpResult)
            }
        } else {
            completionHandler(HttpResult.clientError())
        }

    }

    func postJsonEncoded(payload: String?, path: String, completionHandler: @escaping (HttpResult) -> Void) {
        if payload != nil {
            let postFromUrlEncodedRequest = PostJsonEncodedRequest(payload: payload!, endpoint: getCollectorUrl(path: path))
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

    func getCollectorUrl() -> String {
        return collectorUrl + "/" + self.sdkKey
    }

    func getCollectorUrl(path: String) -> String {
        return collectorUrl + "/" + path
    }

}
