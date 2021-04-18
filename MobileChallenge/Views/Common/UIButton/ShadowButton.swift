//
//  ShadowButton.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 17/04/2021.
//

import UIKit

class ShadowButton: UIButton {

    override func draw(_ rect: CGRect) {
        updateLayerProperties()
    }
    
    func updateLayerProperties() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
    }
}
