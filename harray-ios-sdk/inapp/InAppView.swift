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
    
    var onNavigation: ((_ navigateTo: String) -> ())?
    
    let kCONTENT_XIB_NAME = "InAppView"
    
    @IBAction func btnCloseAction(_ sender: Any) {
            self.removeFromSuperview()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle(identifier: "com.xennSDK.example")?.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        containerView.fixInView(self)
        
        //Adding WKWebView to the Container View.
        let webView = WKWebView(frame: webViewContainerView.frame)
        webView.fixInView(webViewContainerView)
        webViewContainerView.addSubview(webView)
        webView.navigationDelegate = self
        
        let link = URL(string:"https://www.google.com/")!
        let request = URLRequest(url: link)
        
        webView.load(request)
        
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
}

extension InAppView: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.onNavigation?(webView.url?.absoluteString ?? "")
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
