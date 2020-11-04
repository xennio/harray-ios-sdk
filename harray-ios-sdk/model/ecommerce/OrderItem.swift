//
//  OrderItem.swift
//  harray-ios-sdk
//
//  Created by Yildirim Adiguzel on 1.11.2020.
//  Copyright © 2020 xennio. All rights reserved.
//

import Foundation

@objc public class OrderItem: NSObject {
    private let productId: String
    private let variant: Any?
    private let quantity: Int64
    private let price: Double
    private let discountedPrice: Any?
    private let currency: String
    private let supplierId: Any?

    init(productId: String, variant: Any?, quantity: Int64, price: Double, discountedPrice: Any?, currency: String, supplierId: Any?) {
        self.productId = productId
        self.variant = variant
        self.quantity = quantity
        self.price = price
        self.discountedPrice = discountedPrice
        self.currency = currency
        self.supplierId = supplierId
    }

    func getProductId() -> String {
        self.productId
    }

    func getVariantId() -> Any? {
        self.variant
    }

    func getPrice() -> Double {
        self.price
    }

    func getDiscountedPrice() -> Any? {
        self.discountedPrice
    }

    func getQuantity() -> Int64 {
        self.quantity
    }

    func getCurrency() -> String {
        self.currency
    }

    func getSupplierId() -> Any? {
        self.supplierId
    }
}
