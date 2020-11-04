//
// Created by Yildirim Adiguzel on 3.11.2020.
// Copyright (c) 2020 xennio. All rights reserved.
//

import Foundation

@objc public class EcommerceEventProcessorHandler: NSObject {
    private let eventProcessorHandler: EventProcessorHandler

    init(eventProcessorHandler: EventProcessorHandler) {
        self.eventProcessorHandler = eventProcessorHandler
    }

    @objc public func productView(productId: String, variantId: Any? = nil, price: Double, discountedPrice: Any? = nil, currency: String, supplierId: Any? = nil, path: Any? = nil) {
        var params: Dictionary<String, Any> = Dictionary<String, Any>()
        params["entity"] = "products"
        params["id"] = productId
        params["variant"] = variantId
        params["price"] = price
        params["discountedPrice"] = discountedPrice
        params["currency"] = currency
        params["supplierId"] = supplierId
        params["path"] = path
        self.eventProcessorHandler.pageView(pageType: "productDetail", params: params)
    }

    @objc public func categoryView(categoryId: String, path: String? = nil) {
        var params: Dictionary<String, Any> = Dictionary<String, Any>()
        params["entity"] = "categories"
        params["id"] = categoryId
        params["path"] = path
        self.eventProcessorHandler.pageView(pageType: "categoryPage", params: params)
    }

    @objc public func searchResult(keyword: String, resultCount: Int64, path: String? = nil) {
        var params: Dictionary<String, Any> = Dictionary<String, Any>()
        params["keyword"] = keyword
        params["resultCount"] = resultCount
        params["path"] = path
        self.eventProcessorHandler.pageView(pageType: "searchPage", params: params)
    }

    @objc public func addToCart(productId: String, variant: Any? = nil, quantity: Int64, price: Double, discountedPrice: Any? = nil, currency: String, origin: Any?, basketId: Any?, supplierId: Any? = nil) {
        var params: Dictionary<String, Any> = Dictionary<String, Any>()
        params["entity"] = "products"
        params["id"] = productId
        params["variant"] = variant
        params["quantity"] = quantity
        params["price"] = price
        params["discountedPrice"] = discountedPrice
        params["currency"] = currency
        params["origin"] = origin
        params["supplierId"] = supplierId
        params["basketId"] = basketId
        self.eventProcessorHandler.actionResult(type: "addToCart", params: params)
    }

    @objc public func removeFromCart(productId: String, variantId: Any? = nil, quantity: Int64, basketId: Any?) {
        var params: Dictionary<String, Any> = Dictionary<String, Any>()
        params["entity"] = "products"
        params["id"] = productId
        params["variant"] = variantId
        params["quantity"] = quantity
        params["basketId"] = basketId
        self.eventProcessorHandler.actionResult(type: "removeFromCart", params: params)
    }

    @objc public func cartView(basketId: String) {
        var params: Dictionary<String, Any> = Dictionary<String, Any>()
        params["basketId"] = basketId
        self.eventProcessorHandler.pageView(pageType: "cartView", params: params)
    }

    @objc public func orderFunnel(basketId: String, step: String) {
        var params: Dictionary<String, Any> = Dictionary<String, Any>()
        params["basketId"] = basketId
        params["step"] = step
        self.eventProcessorHandler.pageView(pageType: "orderFunnel", params: params)
    }

    @objc public func orderSuccess( basketId: Any?, order: Order) {
        var params: Dictionary<String, Any> = Dictionary<String, Any>()
        params["basketId"] = basketId
        params["orderId"] = order.getOrderId()
        params["totalAmount"] = order.getTotalAmount()
        params["discountAmount"] = order.getDiscountAmount()
        params["discountName"] = order.getDiscountName()
        params["couponName"] = order.getCouponName()
        params["promotionName"] = order.getPromotionName()
        params["paymentMethod"] = order.getPaymentMethod()
        self.eventProcessorHandler.pageView(pageType: "orderSuccess", params: params)

        for item in order.getOrderItems() {
            var orderItemParams: Dictionary<String, Any> = Dictionary<String, Any>()
            orderItemParams["orderId"] = order.getOrderId()
            orderItemParams["entity"] = "products"
            orderItemParams["id"] = item.getProductId()
            orderItemParams["variant"] = item.getVariantId()
            orderItemParams["quantity"] = item.getQuantity()
            orderItemParams["price"] = item.getPrice()
            orderItemParams["discountedPrice"] = item.getDiscountedPrice()
            orderItemParams["currency"] = item.getCurrency()
            orderItemParams["supplierId"] = item.getSupplierId()
            self.eventProcessorHandler.actionResult(type: "conversion", params: orderItemParams)
        }
    }

}
