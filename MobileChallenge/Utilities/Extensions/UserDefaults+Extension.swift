//
//  UserDefaults+Extension.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 21/04/2021.
//

import Foundation

extension UserDefaults {
    func executeIfFalseThenToggle(forKey key: String, completion: (() -> Void)?) {
        if !self.bool(forKey: key) {
            completion?()
            self.setValue(true, forKey: key)
            self.synchronize()
        }
    }
}
