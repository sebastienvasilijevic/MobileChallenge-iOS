//
//  LoadingReusableView.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 17/04/2021.
//

import SnapKit
import UIKit

class LoadingReusableView: UICollectionReusableView {
    static let reuseIdentifer: String = "loadingReuseIdentifier"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Init views
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let v: UIActivityIndicatorView = .init(style: .medium)
        v.hidesWhenStopped = true
        return v
    }()
}

extension LoadingReusableView {
    func setupViews() {
        self.clipsToBounds = true
        
        self.addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func startAnimating() {
        self.activityIndicator.startAnimating()
    }
    
    func stopAnimating() {
        self.activityIndicator.stopAnimating()
    }
}
