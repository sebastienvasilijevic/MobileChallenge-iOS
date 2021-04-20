//
//  MCTagCollectionView.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 20/04/2021.
//

import UIKit

class MCTagCollectionView: UICollectionView {
    
    var isDynamicSizeRequired: Bool = false
    var isUserEditing: Bool = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {

            if self.intrinsicContentSize.height > frame.size.height {
                self.invalidateIntrinsicContentSize()
            }
            if isDynamicSizeRequired {
                self.invalidateIntrinsicContentSize()
            }
        }
    }
    
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}
