//
//  PlaceholderView.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 20/04/2021.
//

import UIKit

class PlaceholderView: UIView {
    
    private lazy var mainStackView: UIStackView = {
        let v: UIStackView = .init(arrangedSubviews: [imageView, textLabel, buttonsStackView])
        v.axis = .vertical
        v.alignment = .center
        v.spacing = kMC.UI.margins
        return v
    }()
    
    private(set) lazy var buttonsStackView: UIStackView = {
        let v: UIStackView = .init()
        v.axis = .vertical
        v.spacing = kMC.UI.margins/2.0
        return v
    }()
    private(set) lazy var imageView: UIImageView = {
        let v: UIImageView = .init()
        v.contentMode = .scaleAspectFit
        return v
    }()
    
    private(set) lazy var textLabel: UILabel = {
        let v: UILabel = .init()
        v.font = kMC.Font.bold.withSize(kMC.Font.defaultSize+4)
        v.textColor = kMC.Colors.Text.primary
        v.textAlignment = .center
        v.numberOfLines = 6
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        
        self.addSubview(mainStackView)
        
        mainStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.lessThanOrEqualToSuperview().inset(kMC.UI.margins).priority(.high)
            make.width.equalToSuperview().inset(kMC.UI.margins).priority(.high)
        }
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(150)
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.width.lessThanOrEqualTo(mainStackView.snp.width)
            make.width.equalTo(250)
        }
    }

    convenience init(frame: CGRect, image: UIImage?, text: String) {
        self.init(frame: frame)
        
        imageView.image = image
        
        textLabel.text = text
        textLabel.isHidden = text.isEmpty
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func setImage(image: UIImage?) {
        imageView.image = image
    }
    
    public func setText(text: String?) {
        textLabel.text = text
        textLabel.isHidden = text == nil || text!.isEmpty
    }
    
    private func getButton(icon: UIImage?, title: String?, type: CustomButton.CustomButtonType, handler: ((PlaceholderView) -> Void)?) -> CustomButton {
        let b: CustomButton = .init()
        b.type = type
        b.frame.size.height = 54
        b.layer.cornerRadius = b.frame.size.height/2
        b.titleLabel?.font = kMC.Font.bold.withSize(kMC.Font.defaultSize+1)
        self.setButtonProperties(button: b, icon: icon, title: title)
        if handler != nil {
            b.addAction(for: .touchUpInside) { button in
                handler?(self)
            }
        }
        
        b.imageView?.contentMode = .scaleAspectFit
        
        return b
    }
    
    @discardableResult
    public func addButton(icon: UIImage?, title: String?, type: CustomButton.CustomButtonType, handler: ((PlaceholderView) -> Void)?) -> PlaceholderView {
        let b: CustomButton = getButton(icon: icon, title: title, type: type, handler: handler)
        
        buttonsStackView.addArrangedSubview(b)
        
        b.snp.makeConstraints { make in
            make.height.equalTo(54)
        }
        
        return self
    }
    
    public func replaceButton(at index: Int, icon: UIImage?, title: String?, type: CustomButton.CustomButtonType, handler: ((PlaceholderView) -> Void)?) {
        guard index < buttonsStackView.arrangedSubviews.count else {
            return
        }
        
        let b: CustomButton = buttonsStackView.arrangedSubviews[index] as! CustomButton
        self.setButtonProperties(button: b, icon: icon, title: title)
        
        if handler != nil {
            b.addAction(for: .touchUpInside) { button in
                handler?(self)
            }
        }
    }
    
    private func setButtonProperties(button: UIButton, icon: UIImage?, title: String?) {
        button.setImage(icon == nil ? UIImage() : icon, for: .normal)
        button.setTitle(title == nil ? "" : title, for: .normal)
        button.imageEdgeInsets = icon != nil ? .init(top: 16.0, left: -6.0, bottom: 16.0, right: 6.0) : .init()
        button.titleEdgeInsets = icon != nil ? .init(top: 0, left: 6.0, bottom: 0, right: -6.0) : .init()
        button.contentEdgeInsets = icon != nil ? .init(top: 0, left: 23.0, bottom: 0, right: 23.0) : .init()
    }
}
