//
//  MainSplitViewController.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 20/04/2021.
//

import UIKit

class MainSplitViewController: UISplitViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        if let vc = self.viewControllers[0] as? MainNavigationController {
            return vc.preferredStatusBarStyle
        } else if let vc = self.viewControllers[0] as? MainViewController {
            return vc.preferredStatusBarStyle
        }
        return .lightContent
    }
}
