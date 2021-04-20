//
//  UICollectionView+Extension.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 20/04/2021.
//

import UIKit

extension UICollectionView {
    func showBackgroundView() {
        self.backgroundView?.isHidden = false
    }
    
    func hideBackgroundView() {
        self.backgroundView?.isHidden = true
    }
}
