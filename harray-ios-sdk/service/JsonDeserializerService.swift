//
//  JsonDeserializerService.swift
//  harray-ios-sdk
//
//  Created by Bay Batu on 27.01.2021.
//  Copyright © 2021 xennio. All rights reserved.
//

import Foundation

class JsonDeserializerService {
    
    private let jsonDecoder: JSONDecoder
    
    init() {
        self.jsonDecoder = JSONDecoder()
    }
    
    func deserialize<T: Decodable>(jsonString: String) -> T? {
        do {
            return try jsonDecoder.decode(T.self, from: jsonString.data(using: .utf8)!)
        } catch {
            XennioLogger.log(message: "Json deserialize error for jsonString: \(jsonString)")
            return nil
        }
    }
    
    func deserializeToDictArray(jsonString: String) -> Array<Dictionary<String, String>>? {
        let jsonData = jsonString.data(using: .utf8)!
        do {
            if let rawArrDict = try JSONSerialization.jsonObject(with: jsonData) as? [[String: Any]] {
                return rawArrDict.map { m in m.mapValues { "\($0)" } }
            } else {
                XennioLogger.log(message: "Json deserialize type conversion error for jsonString: \(jsonString)")
                return nil
            }
        } catch {
            XennioLogger.log(message: "Json deserialize error for jsonString: \(jsonString)")
            return nil
        }
    }
}
