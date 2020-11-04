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
    private var promotionName: String?
    private var totalAmount: Double
    private var discountedAmount: Double?
    private var paymentMethod: String
    private var discountName: String?
    private var couponName: String?

    init(orderId: String) {
        self.orderId = orderId
    }

    @objc public class func create(orderId: String) -> Order {
        Order(orderId: orderId)
    }

    @objc func addItem(productId: String, variantId: String?, quantity: Int64, price: Double, discountedPrice: Double?, currency: String, supplierId: String?) -> Order {
        orderItems.append(OrderItem(productId: productId, variantId: variantId, quantity: quantity, price: price, discountedPrice: discountedPrice, currency: currency, supplierId: supplierId))
        return self
    }

    @objc func paidWith(paymentMethod: String) -> Order {
        self.paymentMethod = paymentMethod
        self
    }

    @objc func withPromotion(promotionName: String?) -> Order {
        self.promotionName = promotionName
        self
    }

    @objc func withDiscount(discountName: String?) -> Order {
        self.discountName = discountName
        self
    }

    @objc func withCoupon(couponName: String?) -> Order {
        self.couponName = couponName
        self
    }

    @objc func totalAmount(totalAmount: Double) -> Order {
        self.totalAmount = totalAmount
        self
    }

    @objc func discountedAmount(discountedAmount: Double?) -> Order {
        self.discountedAmount = discountedAmount
        self
    }

    @objc func getOrderId() -> String {
        self.orderId
    }

    @objc func getTotalAmount() -> Double {
        self.totalAmount
    }

    @objc func getDiscountAmount() -> Double? {
        self.discountedAmount
    }

    @objc func getDiscountName() -> String? {
        self.discountName
    }

    @objc func getCouponName() -> String? {
        self.couponName
    }

    @objc func getPromotionName() -> String? {
        self.promotionName
    }

    @objc func getPaymentMethod() -> String {
        self.paymentMethod
    }

    func getOrderItems() -> [OrderItem] {
        self.orderItems
    }
}
