//
//  HttpService.swift
//  harray-ios-sdk
//
//  Created by YILDIRIM ADIGÜZEL on 21.04.2020.
//  Copyright © 2020 xennio. All rights reserved.
//

import Foundation

class HttpService {

    private let collectorUrl = "https://c.xenn.io"
    private let apiUrl = "https://api.xenn.io"
    private let sdkKey: String
    private let session: HttpSession

    init(sdkKey: String, session: HttpSession) {
        self.session = session
        self.sdkKey = sdkKey
    }
    
    func getApiRequest(path: String,
                       params: Dictionary<String, String>,
                       responseHandler: @escaping (HttpResult) -> [[String: String]]?,
                       completionHandler: @escaping ([[String: String]]?) -> Void) {
        let endpoint = getApiUrl(path: path, params: params)
        let request = ApiGetJsonRequest(endpoint: endpoint)
        session.doRequest(from: request.getUrlRequest()) { httpResult in
            if httpResult.isSuccess() {
                completionHandler(responseHandler(httpResult))
            } else {
                XennioLogger.log(message: "getApiRequest error. Detail: \(httpResult.toString())")
            }
        }
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

    func getApiUrl(path: String, params: [String: String]) -> String {
        var components = URLComponents(string: self.apiUrl)!
        components.path = path.starts(with: "/") ? path : "/\(path)"
        let queryItems = params.map { (paramKey, paramValue) in
            URLQueryItem(name: paramKey, value: paramValue)
        }
        components.queryItems = queryItems
        return components.url!.absoluteString
    }
}
