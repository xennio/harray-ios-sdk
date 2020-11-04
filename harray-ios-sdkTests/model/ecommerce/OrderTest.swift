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
            .addItem(productId: "product1", variantId: "variant1", quantity: 3, price: 300, discountedPrice: Double.init(200), currency: "USD", supplierId: "supplier1")
                .addItem(productId: "product2", variantId: "variant2", quantity: 1, price: 100, discountedPrice: Double.init(76), currency: "USD", supplierId: "supplier2")
                .addItem(productId: "product3", variantId: "variant2", quantity: 4, price: 1300, discountedPrice: Double.init(1200), currency: "USD", supplierId: "supplier3")
                .paidWith(paymentMethod: "creditCard")
                .totalAmount(totalAmount: 3220)
                .withPromotion(promotionName: "promotionName")
                .withDiscount(discountName: "discountName")
                .withCoupon(couponName: "couponName")

        XCTAssertTrue(3 == order.getOrderItems().count)
        XCTAssertTrue("orderId" == order.getOrderId())
        XCTAssertTrue("creditCard" == order.getPaymentMethod() as! String)
        XCTAssertTrue(3220 == order.getTotalAmount() as! Double)
        XCTAssertTrue("promotionName" == order.getPromotionName() as! String)
        XCTAssertTrue("discountName" == order.getDiscountName() as! String)
        XCTAssertTrue("couponName" == order.getCouponName() as! String)
        XCTAssertNil(order.getDiscountAmount())

        let orderItem1 = order.getOrderItems()[0]

        XCTAssertTrue("product1" == orderItem1.getProductId())
        XCTAssertTrue("variant1" == orderItem1.getVariantId() as! String)
        XCTAssertTrue(3 == orderItem1.getQuantity())
        XCTAssertTrue(300 == orderItem1.getPrice())
        XCTAssertTrue(200 == orderItem1.getDiscountedPrice() as! Double)
        XCTAssertTrue("USD" == orderItem1.getCurrency())
        XCTAssertTrue("supplier1" == orderItem1.getSupplierId() as! String)

        let orderItem2 = order.getOrderItems()[1]

        XCTAssertTrue("product2" == orderItem2.getProductId())
        XCTAssertTrue("variant2" == orderItem2.getVariantId() as! String)
        XCTAssertTrue(1 == orderItem2.getQuantity())
        XCTAssertTrue(100 == orderItem2.getPrice())
        XCTAssertTrue(76 == orderItem2.getDiscountedPrice() as! Double)
        XCTAssertTrue("USD" == orderItem2.getCurrency())
        XCTAssertTrue("supplier2" == orderItem2.getSupplierId() as! String)

        let orderItem3 = order.getOrderItems()[2]

        XCTAssertTrue("product3" == orderItem3.getProductId())
        XCTAssertTrue("variant2" == orderItem3.getVariantId() as! String)
        XCTAssertTrue(4 == orderItem3.getQuantity())
        XCTAssertTrue(1300 == orderItem3.getPrice())
        XCTAssertTrue(1200 == orderItem3.getDiscountedPrice() as! Double)
        XCTAssertTrue("USD" == orderItem3.getCurrency())
        XCTAssertTrue("supplier3" == orderItem3.getSupplierId() as! String)
    }
}
