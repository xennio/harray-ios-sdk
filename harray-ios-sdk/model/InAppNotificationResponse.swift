//
//  InAppNotificationResponse.swift
//  harray-ios-sdk
//
//  Created by Yildirim Adiguzel on 28.09.2021.
//  Copyright © 2021 xennio. All rights reserved.
//

import Foundation

class InAppNotificationResponse: Decodable{
    let id: String
    let style: String
    let html: String
    let imageUrl: String?
}
