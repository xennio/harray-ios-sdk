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
        Order(orderId: orderId)
    }

    @objc func addItem(productId: String, variantId: Any?, quantity: Int64, price: Double, discountedPrice: Any?, currency: String, supplierId: Any?) -> Order {
        orderItems.append(OrderItem(productId: productId, variant: variantId, quantity: quantity, price: price, discountedPrice: discountedPrice, currency: currency, supplierId: supplierId))
        return self
    }

    @objc func paidWith(paymentMethod: String) -> Order {
        self.paymentMethod = paymentMethod
        return self
    }

    @objc func withPromotion(promotionName: String?) -> Order {
        self.promotionName = promotionName
        return self
    }

    @objc func withDiscount(discountName: String?) -> Order {
        self.discountName = discountName
        return self
    }

    @objc func withCoupon(couponName: String?) -> Order {
        self.couponName = couponName
        return self
    }

    @objc func totalAmount(totalAmount: Double) -> Order {
        self.totalAmount = totalAmount
        return self
    }

    @objc func discountedAmount(discountedAmount: Any?) -> Order {
        self.discountedAmount = discountedAmount
        return self
    }

    @objc func getOrderId() -> String {
        self.orderId
    }

    @objc func getTotalAmount() -> Any? {
        self.totalAmount
    }

    @objc func getDiscountAmount() -> Any? {
        self.discountedAmount
    }

    @objc func getDiscountName() -> Any? {
        self.discountName
    }

    @objc func getCouponName() -> Any? {
        self.couponName
    }

    @objc func getPromotionName() -> Any? {
        self.promotionName
    }

    @objc func getPaymentMethod() -> Any? {
        self.paymentMethod
    }

    func getOrderItems() -> [OrderItem] {
        self.orderItems
    }
}
