//
//  MemberSummary.swift
//  harray-ios-sdk
//
//  Created by YILDIRIM ADIGÜZEL on 10/7/22.
//  Copyright © 2022 xennio. All rights reserved.
//

import Foundation

@objc public class MemberSummary: NSObject, Decodable {
    let member: Member?
    let ratios: [AttirbuteValues]?
    let ranges: RangeStatistics?
}

@objc public class Member: NSObject, Decodable{
    let id: String?
    let name: String?
    let surname: String?
    let lastSeen: Date?
    let registerDate: Date?
    let segments: [String]?
}

@objc public class AttirbuteValues: NSObject, Decodable {
    let attribute: String?
    let values: [KeyValuePair]?
}

@objc public class KeyValuePair: NSObject, Decodable {
    let key: String?
    let value: Double?
}

@objc public class PriceStatistics: NSObject, Decodable {
    let min: Double?
    let max: Double?
    let avg: Double?
}

@objc public class RangeStatistics: NSObject, Decodable {
    let price: PriceStatistics?
}
