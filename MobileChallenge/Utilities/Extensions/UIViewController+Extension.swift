//
//  UIViewController+Extension.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 20/04/2021.
//

import UIKit

extension UIViewController {
    func sceneDelegate() -> SceneDelegate? {
        return self.view.window?.windowScene?.delegate as? SceneDelegate
    }
    
    func isModal() -> Bool {
        return self.presentingViewController?.presentedViewController == self
            || (self.navigationController != nil && self.navigationController?.presentingViewController?.presentedViewController == self.navigationController)
            || self.tabBarController?.presentingViewController is UITabBarController
    }
}
