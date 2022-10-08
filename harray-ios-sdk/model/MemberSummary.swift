//
//  MemberSummary.swift
//  harray-ios-sdk
//
//  Created by YILDIRIM ADIGÜZEL on 10/7/22.
//  Copyright © 2022 xennio. All rights reserved.
//

import Foundation

public class MemberSummary: Decodable{
    let member: Member?
    let ratios: [AttirbuteValues]?
    let ranges: RangeStatistics?
}

public class Member: Decodable{
    let id: String?
    let name: String?
    let surname: String?
    let lastSeen: Date?
    let registerDate: Date?
    let segments: [String]?
}

public class AttirbuteValues: Decodable {
    let attribute: String?
    let values: [KeyValuePair]?
}

public class KeyValuePair: Decodable {
    let key: String?
    let value: Double?
}

public class PriceStatistics: Decodable {
    let min: Double?
    let max: Double?
    let avg: Double?
}

public class RangeStatistics:Decodable {
    let price: PriceStatistics?
}
