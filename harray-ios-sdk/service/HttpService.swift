//
//  HttpService.swift
//  harray-ios-sdk
//
//  Created by YILDIRIM ADIGÜZEL on 21.04.2020.
//  Copyright © 2020 xennio. All rights reserved.
//

import Foundation
import UserNotifications

class HttpService {

    private let collectorUrl: String
    private let session: URLSession

    init(collectorUrl: String, session: URLSession) {
        self.collectorUrl = collectorUrl
        self.session = session
    }

    func postFormUrlEncoded(payload: String?) {
        if payload != nil {
            let url = URL(string: self.collectorUrl)
            if url != nil {
                var r = URLRequest(url: url!)
                r.httpMethod = "POST"
                r.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

                let d = "e=\(payload!)".data(using: String.Encoding.ascii, allowLossyConversion: false)
                r.httpBody = d
                let task = session.dataTask(with: r) { data, response, error in
                    if let httpResponse = response as? HTTPURLResponse {
                        print(httpResponse.statusCode)
                    }
                }
                task.resume()
            }
        } else {
            XennioLogger.log(message: "Attempt to store nil value")
        }
    }

    func downloadImage(endpoint: String?, with completionHandler: @escaping (UNNotificationAttachment?) -> Void) {
        guard let imageUrlString = endpoint else {
            completionHandler(nil)
            return
        }

        let imageUrlOptional = URL(string: imageUrlString)
        guard let imageUrl = imageUrlOptional else {
            completionHandler(nil)
            return
        }

        let task = session.downloadTask(with: imageUrl) { (downloadedUrl: URL?, response: URLResponse?, error: Error?) -> Void in
            guard let downloadedUrl = downloadedUrl else {
                completionHandler(nil)
                return
            }

            let extensionIndex = imageUrlString.lastIndex(of: ".")
            guard let index = extensionIndex else {
                completionHandler(nil)
                return
            }

            let fileExtension = imageUrlString[index...]

            var urlPath = URL(fileURLWithPath: NSTemporaryDirectory())
            let uniqueURLEnding = ProcessInfo.processInfo.globallyUniqueString + fileExtension
            urlPath = urlPath.appendingPathComponent(uniqueURLEnding)

            try? FileManager.default.moveItem(at: downloadedUrl, to: urlPath)

            do {
                let attachment = try UNNotificationAttachment(identifier: "picture", url: urlPath, options: nil)
                completionHandler(attachment)
            } catch {
                completionHandler(nil)
            }

        }
        task.resume()
    }

}
