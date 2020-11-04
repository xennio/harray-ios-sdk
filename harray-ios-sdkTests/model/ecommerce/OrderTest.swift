//
//  OrderTest.swift
//  harray-ios-sdkTests
//
//  Created by Yildirim Adiguzel on 1.11.2020.
//  Copyright © 2020 xennio. All rights reserved.
//

import XCTest

class OrderTest: XCTestCase {

    func test_it_should_create_order_with_given_payment_method() {
        let order = Order.create(orderId: "orderId")
                .addItem(productId: "product1", variantId: "variant1", quantity: 3, price: 300, discountedPrice: 200, currency: "USD", supplierId: "supplier1")
                .addItem(productId: "product2", variantId: "variant2", quantity: 1, price: 100, discountedPrice: 76, currency: "USD", supplierId: "supplier2")
                .addItem(productId: "product3", variantId: "variant2", quantity: 4, price: 1300, discountedPrice: 1200, currency: "USD", supplierId: "supplier3")
                .paidWith(paymentMethod: "creditCard")
                .totalAmount(totalAmount: 3220)
                .withPromotion(promotionName: "promotionName")
                .withDiscount(discountName: "discountName")
                .withCoupon(couponName: "couponName")

        XCTAssertTrue(3 == order.getOrderItems().count)
        XCTAssertTrue("orderId" == order.getOrderId())
        XCTAssertTrue("creditCard" == order.getPaymentMethod())
        XCTAssertTrue(3220 == order.getTotalAmount())
        XCTAssertTrue("promotionName" == order.getPromotionName())
        XCTAssertTrue("discountName" == order.getDiscountName())
        XCTAssertTrue("couponName" == order.getCouponName())
        XCTAssertNil(order.getDiscountAmount())

        let orderItem1 = order.getOrderItems()[0]

        XCTAssertTrue("product1" == orderItem1.getProductId())
        XCTAssertTrue("variant1" == orderItem1.getVariantId())
        XCTAssertTrue(3 == orderItem1.getQuantity())
        XCTAssertTrue(300 == orderItem1.getPrice())
        XCTAssertTrue(200 == orderItem1.getDiscountedPrice())
        XCTAssertTrue("USD" == orderItem1.getCurrency())
        XCTAssertTrue("supplier1" == orderItem1.getSupplierId())

        let orderItem2 = order.getOrderItems()[1]

        XCTAssertTrue("product2" == orderItem2.getProductId())
        XCTAssertTrue("variant2" == orderItem2.getVariantId())
        XCTAssertTrue(1 == orderItem2.getQuantity())
        XCTAssertTrue(100 == orderItem2.getPrice())
        XCTAssertTrue(76 == orderItem2.getDiscountedPrice())
        XCTAssertTrue("USD" == orderItem2.getCurrency())
        XCTAssertTrue("supplier2" == orderItem2.getSupplierId())

        let orderItem3 = order.getOrderItems()[0]

        XCTAssertTrue("product3" == orderItem3.getProductId())
        XCTAssertTrue("variant2" == orderItem3.getVariantId())
        XCTAssertTrue(4 == orderItem3.getQuantity())
        XCTAssertTrue(1300 == orderItem3.getPrice())
        XCTAssertTrue(1200 == orderItem3.getDiscountedPrice())
        XCTAssertTrue("USD" == orderItem3.getCurrency())
        XCTAssertTrue("supplier3" == orderItem3.getSupplierId())
    }
}