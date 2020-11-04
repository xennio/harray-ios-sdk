//
// Created by Yildirim Adiguzel on 3.11.2020.
// Copyright (c) 2020 xennio. All rights reserved.
//

import XCTest

class EcommerceEventProcessorHandlerTest: XCTestCase {

    func test_it_should_create_product_view_event() {
        let capturingEventProcessorHandler = CapturingEventProcessorHandler()
        let ecommerceEventProcessorHandler = EcommerceEventProcessorHandler(eventProcessorHandler: capturingEventProcessorHandler)

        ecommerceEventProcessorHandler.productView(productId: "productId", variantId: "small", price: 300, currency: "USD", supplierId: "supplier1")

        let params = capturingEventProcessorHandler.capturedParams[0]
        let pageType = capturingEventProcessorHandler.pageType!

        XCTAssertEqual("productDetail", pageType)
        XCTAssertEqual("products", params["entity"] as! String)
        XCTAssertEqual("productId", params["id"] as! String)
        XCTAssertEqual("small", params["variant"] as! String)
        XCTAssertEqual(400, params["price"] as! Double)
        XCTAssertEqual(300, params["discountedPrice"] as! Double)
        XCTAssertEqual("USD", params["currency"] as! String)
        XCTAssertEqual("supplier1", params["supplierId"] as! String)
        XCTAssertNil(params["path"])
    }

    func test_it_should_create_category_view_event() {
        let capturingEventProcessorHandler = CapturingEventProcessorHandler()
        let ecommerceEventProcessorHandler = EcommerceEventProcessorHandler(eventProcessorHandler: capturingEventProcessorHandler)

        ecommerceEventProcessorHandler.categoryView(categoryId: "categoryId", path: "resolvedPath")

        let params = capturingEventProcessorHandler.capturedParams[0]
        let pageType = capturingEventProcessorHandler.pageType!

        XCTAssertEqual("categoryPage", pageType)
        XCTAssertEqual("categories", params["entity"] as! String)
        XCTAssertEqual("categoryId", params["id"] as! String)
        XCTAssertEqual("resolvedPath", params["path"] as! String)
    }

    func test_it_should_create_search_view_event() {
        let capturingEventProcessorHandler = CapturingEventProcessorHandler()
        let ecommerceEventProcessorHandler = EcommerceEventProcessorHandler(eventProcessorHandler: capturingEventProcessorHandler)

        ecommerceEventProcessorHandler.searchResult(keyword: "search keyword", resultCount: 200, path: "resolvedPath")

        let params = capturingEventProcessorHandler.capturedParams[0]
        let pageType = capturingEventProcessorHandler.pageType!

        XCTAssertEqual("searchPage", pageType)
        XCTAssertEqual("search keyword", params["keyword"] as! String)
        XCTAssertEqual(200, params["resultCount"] as! Int64)
        XCTAssertEqual("resolvedPath", params["path"] as! String)
    }

    func test_it_should_create_add_to_cart_event() {
        let capturingEventProcessorHandler = CapturingEventProcessorHandler()
        let ecommerceEventProcessorHandler = EcommerceEventProcessorHandler(eventProcessorHandler: capturingEventProcessorHandler)

        ecommerceEventProcessorHandler.addToCart(productId: "productId", variant: "small", quantity: 3, price: 300, discountedPrice: 200, currency: "USD", origin: "detailPage", basketId: "basket1", supplierId: "supplier1")

        let params = capturingEventProcessorHandler.capturedParams[0]
        let actionType = capturingEventProcessorHandler.actionType!

        XCTAssertEqual("addToCart", actionType)
        XCTAssertEqual("products", params["entity"] as! String)
        XCTAssertEqual("productId", params["id"] as! String)
        XCTAssertEqual("small", params["variant"] as! String)
        XCTAssertEqual(3, params["quantity"] as! Int64)
        XCTAssertEqual(300, params["price"] as! Double)
        XCTAssertEqual(200, params["discountedPrice"] as! Double)
        XCTAssertEqual("USD", params["currency"] as! String)
        XCTAssertEqual("supplier1", params["supplierId"] as! String)
        XCTAssertEqual("detailPage", params["origin"] as! String)
        XCTAssertEqual("basket1", params["basketId"] as! String)
    }

    func test_it_should_create_remove_from_cart_event() {
        let capturingEventProcessorHandler = CapturingEventProcessorHandler()
        let ecommerceEventProcessorHandler = EcommerceEventProcessorHandler(eventProcessorHandler: capturingEventProcessorHandler)

        ecommerceEventProcessorHandler.removeFromCart(productId: "productId", variantId: "small", quantity: 3, basketId: "basket1")

        let params = capturingEventProcessorHandler.capturedParams[0]
        let actionType = capturingEventProcessorHandler.actionType!

        XCTAssertEqual("removeFromCart", actionType)
        XCTAssertEqual("products", params["entity"] as! String)
        XCTAssertEqual("productId", params["id"] as! String)
        XCTAssertEqual("small", params["variant"] as! String)
        XCTAssertEqual(3, params["quantity"] as! Int64)
    }

    func test_it_should_create_cart_view_page() {
        let capturingEventProcessorHandler = CapturingEventProcessorHandler()
        let ecommerceEventProcessorHandler = EcommerceEventProcessorHandler(eventProcessorHandler: capturingEventProcessorHandler)

        ecommerceEventProcessorHandler.cartView(basketId: "basketId")

        let params = capturingEventProcessorHandler.capturedParams[0]
        let pageType = capturingEventProcessorHandler.pageType!

        XCTAssertEqual("cartView", pageType)
        XCTAssertEqual("basketId", params["basketId"] as! String)
    }

    func test_it_should_create_order_funnel_event() {
        let capturingEventProcessorHandler = CapturingEventProcessorHandler()
        let ecommerceEventProcessorHandler = EcommerceEventProcessorHandler(eventProcessorHandler: capturingEventProcessorHandler)

        ecommerceEventProcessorHandler.orderFunnel(basketId: "basketId", step: "addressPage")

        let params = capturingEventProcessorHandler.capturedParams[0]
        let pageType = capturingEventProcessorHandler.pageType!

        XCTAssertEqual("orderFunnel", pageType)
        XCTAssertEqual("basketId", params["basketId"] as! String)
        XCTAssertEqual("addressPage", params["step"] as! String)
    }

    func test_it_should_create_order_success_events() {
        let capturingEventProcessorHandler = CapturingEventProcessorHandler()
        let ecommerceEventProcessorHandler = EcommerceEventProcessorHandler(eventProcessorHandler: capturingEventProcessorHandler)

        let order = Order.create(orderId: "orderId")
                .addItem(productId: "product1", variantId: "variant1", quantity: 3, price: 300, discountedPrice: 200, currency: "USD", supplierId: "supplier1")
                .addItem(productId: "product2", variantId: "variant2", quantity: 1, price: 100, discountedPrice: 76, currency: "USD", supplierId: "supplier2")
                .addItem(productId: "product3", variantId: "variant2", quantity: 4, price: 1300, discountedPrice: 1200, currency: "USD", supplierId: "supplier3")
                .paidWith(paymentMethod: "creditCard")
                .totalAmount(totalAmount: 3220)
                .discountedAmount(discountedAmount: 2000)
                .withPromotion(promotionName: "promotionName")
                .withDiscount(discountName: "discountName")
                .withCoupon(couponName: "couponName")

        ecommerceEventProcessorHandler.orderSuccess(basketId: "basketId", order: order)

        let pageViewParams = capturingEventProcessorHandler.capturedParams[0]
        let pageType = capturingEventProcessorHandler.pageType!

        XCTAssertEqual("orderSuccess", pageType)
        XCTAssertEqual("basketId", pageViewParams["basketId"] as! String)
        XCTAssertEqual("orderId", pageViewParams["orderId"] as! String)
        XCTAssertEqual(3220, pageViewParams["totalAmount"] as! Double)
        XCTAssertEqual(2000, pageViewParams["discountAmount"] as! Double)
        XCTAssertEqual("discountName", pageViewParams["discountName"] as! String)
        XCTAssertEqual("couponName", pageViewParams["couponName"] as! String)
        XCTAssertEqual("promotionName", pageViewParams["promotionName"] as! String)
        XCTAssertEqual("paymentMethod", pageViewParams["paymentMethod"] as! String)

        let actionType = capturingEventProcessorHandler.actionType!
        let actionResultInvokeCount = capturingEventProcessorHandler.actionResultInvokeCount
        XCTAssertEqual(3, actionResultInvokeCount)

        let conversion1Params = capturingEventProcessorHandler.capturedParams[1]
        XCTAssertEqual("product1", conversion1Params["id"] as! String);
        XCTAssertEqual("products", conversion1Params["entity"] as! String);
        XCTAssertEqual("variant1", conversion1Params["variant"] as! String);
        XCTAssertEqual("orderId", conversion1Params["orderId"] as! String);
        XCTAssertEqual(3, conversion1Params["quantity"] as! Int64);
        XCTAssertEqual(300, conversion1Params["price"] as! Double);
        XCTAssertEqual(200, conversion1Params["discountedPrice"] as! Double);
        XCTAssertEqual("USD", conversion1Params["currency"] as! String);
        XCTAssertEqual("orderId", conversion1Params["orderId"] as! String);
        XCTAssertEqual("supplier1", conversion1Params["supplierId"] as! String);

        let conversion2Params = capturingEventProcessorHandler.capturedParams[2]

        XCTAssertEqual("product2", conversion2Params["id"] as! String);
        XCTAssertEqual("products", conversion2Params["entity"] as! String);
        XCTAssertEqual("variant2", conversion2Params["variant"] as! String);
        XCTAssertEqual("orderId", conversion2Params["orderId"] as! String);
        XCTAssertEqual(1, conversion2Params["quantity"] as! Int64);
        XCTAssertEqual(100, conversion2Params["price"] as! Double);
        XCTAssertEqual(76, conversion2Params["discountedPrice"] as! Double);
        XCTAssertEqual("USD", conversion2Params["currency"] as! String);
        XCTAssertEqual("orderId", conversion2Params["orderId"] as! String);
        XCTAssertEqual("supplier2", conversion2Params["supplierId"] as! String);

        let conversion3Params = capturingEventProcessorHandler.capturedParams[3]

        XCTAssertEqual("product3", conversion3Params["id"] as! String);
        XCTAssertEqual("products", conversion3Params["entity"] as! String);
        XCTAssertEqual("variant2", conversion3Params["variant"] as! String);
        XCTAssertEqual("orderId", conversion3Params["orderId"] as! String);
        XCTAssertEqual(4, conversion3Params["quantity"] as! Int64);
        XCTAssertEqual(1300, conversion3Params["price"] as! Double);
        XCTAssertEqual(1200, conversion3Params["discountedPrice"] as! Double);
        XCTAssertEqual("USD", conversion3Params["currency"] as! String);
        XCTAssertEqual("orderId", conversion3Params["orderId"] as! String);
        XCTAssertEqual("supplier3", conversion3Params["supplierId"] as! String);
    }
}
