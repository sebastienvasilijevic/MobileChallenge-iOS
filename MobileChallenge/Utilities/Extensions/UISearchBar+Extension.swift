//
//  UISearchBar-Extension.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 17/04/2021.
//

import SnapKit
import UIKit

extension UISearchBar {
    public var textField: UITextField? {
        return self.value(forKey: "searchField") as? UITextField
    }
    
    public var activityIndicator: UIActivityIndicatorView? {
        return textField?.leftView?.subviews.compactMap{ $0 as? UIActivityIndicatorView }.first
    }
    
    var isLoading: Bool {
        get {
            return activityIndicator != nil
        } set {
            if newValue {
                if activityIndicator == nil {
                    let newActivityIndicator: UIActivityIndicatorView = .init(style: .medium)
                    newActivityIndicator.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                    newActivityIndicator.startAnimating()
                    newActivityIndicator.backgroundColor = textField?.backgroundColor
                    textField?.leftView?.addSubview(newActivityIndicator)
                    
                    newActivityIndicator.snp.makeConstraints { make in
                        make.center.equalToSuperview()
                    }
                }
            } else {
                activityIndicator?.removeFromSuperview()
            }
        }
    }
}
