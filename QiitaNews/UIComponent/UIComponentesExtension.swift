//
//  UIComponentesExtension.swift
//  News Api App
//
//  Created by VietNezo on 2018/06/21.
//  Copyright © 2018 VietNezo. All rights reserved.
//

import UIKit

extension UIView {

    func showLoaderView() {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.startAnimating()

        blurEffectView.contentView.addSubview(activityIndicator)
        activityIndicator.center = blurEffectView.contentView.center

        self.addSubview(blurEffectView)
    }

    func hideLoaderView() {
        self.subviews.compactMap { $0 as? UIVisualEffectView }.forEach {
            $0.removeFromSuperview()
        }
    }

    func showToast(message: String) {
        var style = ToastStyle()
        style.backgroundColor = .black
        style.cornerRadius = 10
        style.verticalPadding = 30.0
        style.horizontalPadding = 20.0
        style.titleFont = UIFont.boldSystemFont(ofSize: 38.0)

        self.makeToast(message, duration: ToastManager.shared.duration, position: .center, style: style)
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        
        guard let data = data(using: .unicode) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType:  NSAttributedString.DocumentType.html], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
}
