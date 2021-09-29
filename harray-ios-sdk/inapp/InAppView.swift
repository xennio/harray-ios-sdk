//
//  InAppView.swift
//  harray-ios-sdk
//
//  Created by Yildirim Adiguzel on 22.09.2021.
//  Copyright © 2021 xennio. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class InAppView : UIView {
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var webViewContainerView: UIView!
    @IBOutlet var btnClose: UIButton!
    
    var onNavigation: ((_ navigateTo: String) -> ())?
    var onClose: (() -> ())?
    
    let kCONTENT_XIB_NAME = "InAppView"
    
    @IBAction func btnCloseAction(_ sender: Any) {
        closingEvent()
    }
    
    func closingEvent(){
        self.removeFromSuperview()
        self.onClose?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func loadPopup(content: String) {
        Bundle(identifier: "org.cocoapods.Xennio")?.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        let bundle = Bundle(identifier: "org.cocoapods.Xennio")
        bundle?.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        containerView.fixInView(self)
        
        btnClose.setImage(UIImage(named: "icon_close", in: bundle, compatibleWith: nil), for: .normal)
        
        //Adding WKWebView to the Container View.
        let webView = WKWebView(frame: webViewContainerView.frame)
        webView.fixInView(webViewContainerView)
        webViewContainerView.addSubview(webView)
        webView.navigationDelegate = self
        webView.loadHTMLString(content, baseURL: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

extension InAppView: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping ((WKNavigationActionPolicy) -> Void)) {
        let url = navigationAction.request.url?.absoluteString ?? ""
        if(!url.contains("about:blank")){
                self.onNavigation?(url)
                self.closingEvent()
            }
            decisionHandler(.allow)
        }
}

extension UIView {
    func fixInView(_ container: UIView!) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.frame = container.frame
        container.addSubview(self)
        NSLayoutConstraint(item: self,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: container,
                           attribute: .leading,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: self,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: container,
                           attribute: .trailing,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: self,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: container,
                           attribute: .top,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: self,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: container,
                           attribute: .bottom,
                           multiplier: 1.0,
                           constant: 0).isActive = true
    }
}
