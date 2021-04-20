//
//  CustomButton.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 20/04/2021.
//

import UIKit

class CustomButton: UIButton {
    
    enum CustomButtonType {
        case
        none,
        primary
    }
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [.allowUserInteraction, .curveEaseInOut], animations: {
                self.alpha = self.isHighlighted ? 0.5 : 1.0
                
            }, completion: nil)
        }
    }
    
    public var type: CustomButtonType = .none {
        didSet {
            self.setButtonTheme(type: self.type, for: .normal)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.clipsToBounds = true
        self.titleLabel?.font = kMC.Font.bold
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.titleLabel?.minimumScaleFactor = 0.75
        self.titleLabel?.numberOfLines = 2
        self.contentHorizontalAlignment = .center
        self.titleLabel?.textAlignment = .center
        self.adjustsImageWhenHighlighted = false
        
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 0.0
        self.layer.cornerRadius = 4.0
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func setButtonTheme(type: CustomButtonType, alpha: CGFloat = 1.0, for state: UIControl.State) {
        switch type {
        case .none:
            setButtonColors(for: state, alpha: alpha, tint: kMC.Colors.Text.primary, background: .clear, borderWidth: 0.0, borderColor: nil)
        case .primary:
            setButtonColors(for: state, alpha: alpha, tint: kMC.Colors.Text.onMain, background: kMC.Colors.main, borderWidth: 0.0, borderColor: nil)
        }
    }
    
    private func setButtonColors(for state: UIControl.State, alpha: CGFloat, tint: UIColor, background: UIColor, borderWidth: CGFloat, borderColor: UIColor? = nil) {
        if let borderColor = borderColor, borderWidth != 0.0 {
            self.layer.borderColor = borderColor.withAlphaComponent(alpha).cgColor
        }
        self.layer.borderWidth = borderWidth
        if state == .normal {
            self.tintColor = tint.withAlphaComponent(alpha)
        }
        self.setTitleColor(tint.withAlphaComponent(alpha), for: state)
        self.backgroundColor = background
    }
}
