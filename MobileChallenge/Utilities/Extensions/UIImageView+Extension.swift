//
//  UIImageView+Extension.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 18/04/2021.
//

import Kingfisher
import UIKit

extension UIImageView {
    @discardableResult
    func downloadImage(from uri: String, downsampling: Bool) -> DownloadTask? {
        if let url = URL(string: uri) {
            var options: KingfisherOptionsInfo = [
                .cacheOriginalImage,
                .loadDiskFileSynchronously
            ]
            if downsampling {
                self.layoutIfNeeded()
                options.append(.processor(DownsamplingImageProcessor(size: self.bounds.size)))
                options.append(.scaleFactor(UIScreen.main.scale))
            }
            
            self.kf.indicatorType = .activity
            return self.kf.setImage(
                with: url,
                placeholder: UIImage(named: kMC.Images.noPictureImage),
                options: options
            )
        } else {
            return nil
        }
    }
}
