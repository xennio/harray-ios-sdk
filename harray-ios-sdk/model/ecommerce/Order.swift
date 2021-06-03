//
//  Order.swift
//  harray-ios-sdk
//
//  Created by Yildirim Adiguzel on 1.11.2020.
//  Copyright © 2020 xennio. All rights reserved.
//

import Foundation

@objc public class Order: NSObject {
    private let orderId: String
    private var orderItems: [OrderItem] = [OrderItem]()
    private var promotionName: Any?
    private var totalAmount: Any?
    private var discountedAmount: Any?
    private var paymentMethod: Any?
    private var discountName: Any?
    private var couponName: Any?

    init(orderId: String) {
        self.orderId = orderId
    }

    @objc public class func create(orderId: String) -> Order {
        return Order(orderId: orderId)
    }

    @objc public func addItem(productId: String, variantId: Any?, quantity: Int64, price: Double, discountedPrice: Any?, currency: String, supplierId: Any?) -> Order {
        orderItems.append(OrderItem(productId: productId, variant: variantId, quantity: quantity, price: price, discountedPrice: discountedPrice, currency: currency, supplierId: supplierId))
        return self
    }

    @objc public func paidWith(paymentMethod: String) -> Order {
        self.paymentMethod = paymentMethod
        return self
    }

    @objc public func withPromotion(promotionName: String?) -> Order {
        self.promotionName = promotionName
        return self
    }

    @objc public func withDiscount(discountName: String?) -> Order {
        self.discountName = discountName
        return self
    }

    @objc public func withCoupon(couponName: String?) -> Order {
        self.couponName = couponName
        return self
    }

    @objc public func totalAmount(totalAmount: Double) -> Order {
        self.totalAmount = totalAmount
        return self
    }

    @objc public func discountedAmount(discountedAmount: Any?) -> Order {
        self.discountedAmount = discountedAmount
        return self
    }

    @objc public func getOrderId() -> String {
        return self.orderId
    }

    @objc public func getTotalAmount() -> Any? {
        return self.totalAmount
    }

    @objc public func getDiscountAmount() -> Any? {
        return self.discountedAmount
    }

    @objc public func getDiscountName() -> Any? {
        return self.discountName
    }

    @objc public func getCouponName() -> Any? {
        return self.couponName
    }

    @objc public func getPromotionName() -> Any? {
        return self.promotionName
    }

    @objc public func getPaymentMethod() -> Any? {
        return self.paymentMethod
    }

    @objc public func getOrderItems() -> [OrderItem] {
        return self.orderItems
    }
}
