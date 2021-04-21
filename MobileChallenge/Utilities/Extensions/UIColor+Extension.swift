//
//  UIColor+Extension.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 21/04/2021.
//

import UIKit

extension UIColor {
    func isLight(threshold: CGFloat = 0.5) -> Bool? {
        let originalCGColor = self.cgColor

        // Now we need to convert it to the RGB colorspace. UIColor.white / UIColor.black are greyscale and not RGB.
        // If you don't do this then you will crash when accessing components index 2 below when evaluating greyscale colors.
        let RGBCGColor = originalCGColor.converted(to: CGColorSpaceCreateDeviceRGB(), intent: .defaultIntent, options: nil)
        guard let components = RGBCGColor?.components else {
            return nil
        }
        guard components.count >= 3 else {
            return nil
        }
        
        let componentColorRed = components[0]
        let componentColorGreen = components[1]
        let componentColorBlue = components[2]
        
        let brightnessRed: CGFloat = componentColorRed * 299
        let brightnessGreen: CGFloat = componentColorGreen * 587
        let brightnessBlue: CGFloat = componentColorBlue * 114

        let brightness: CGFloat = ((brightnessRed + brightnessGreen + brightnessBlue) / 1000)
        return (brightness > threshold)
    }
}
