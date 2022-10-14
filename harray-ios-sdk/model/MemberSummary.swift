//
//  MemberSummary.swift
//  harray-ios-sdk
//
//  Created by YILDIRIM ADIGÜZEL on 10/7/22.
//  Copyright © 2022 xennio. All rights reserved.
//

import Foundation

@objc public class MemberSummary: NSObject, Decodable {
    public let member: Member?
    public let ratios: [AttirbuteValues]?
    public let ranges: RangeStatistics?
}

@objc public class Member: NSObject, Decodable{
    public let id: String?
    public let name: String?
    public let surname: String?
    public let lastSeen: Date?
    public let registerDate: Date?
    public let segments: [String]?
}

@objc public class AttirbuteValues: NSObject, Decodable {
    public let attribute: String?
    public let values: [KeyValuePair]?
}

@objc public class KeyValuePair: NSObject, Decodable {
    public let key: String?
    public let value: Double?
}

@objc public class PriceStatistics: NSObject, Decodable {
    public let min: Double?
    public let max: Double?
    public let avg: Double?
}

@objc public class RangeStatistics: NSObject, Decodable {
    public let price: PriceStatistics?
}
