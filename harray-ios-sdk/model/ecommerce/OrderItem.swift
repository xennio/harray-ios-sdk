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
    private let variantId: String?
    private let quantity: Int64
    private let price: Double
    private let discountedPrice: Double?
    private let currency: String
    private let supplierId: String?

    init(productId: String, variantId: String?, quantity: Int64, price: Double, discountedPrice: Double?, currency: String, supplierId: String?) {
        self.productId = productId
        self.variantId = variantId
        self.quantity = quantity
        self.price = price
        self.discountedPrice = discountedPrice
        self.currency = currency
        self.supplierId = supplierId
    }

    func getProductId() -> String {
        self.productId
    }

    func getVariantId() -> String? {
        self.variantId
    }

    func getPrice() -> Double {
        self.price
    }

    func getDiscountedPrice() -> Double? {
        self.discountedPrice
    }

    func getQuantity() -> Int64 {
        self.quantity
    }

    func getCurrency() -> String {
        self.currency
    }

    func getSupplierId() -> String? {
        self.supplierId
    }
}
