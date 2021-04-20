//
//  LoadingOverlayView.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 19/04/2021.
//

import SnapKit
import UIKit

class LoadingOverlayView: UIView {
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let v: UIActivityIndicatorView = .init(style: .large)
        return v
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        self.alpha = 0
        self.layer.cornerRadius = 20
        
        self.backgroundColor = kMC.Colors.Background.primaryReverse.withAlphaComponent(0.5)
        
        self.addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    public func startLoading() {
        activityIndicator.color = kMC.Colors.Background.primary
        activityIndicator.startAnimating()
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [.allowUserInteraction, .curveEaseInOut], animations: { [weak self] in
            self?.alpha = 1.0
            
        }, completion: nil)
    }
    
    public func stopLoading() {
        activityIndicator.stopAnimating()
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [.allowUserInteraction, .curveEaseInOut], animations: { [weak self] in
            self?.alpha = 0.0
            
        }, completion: nil)
    }
}
