//
//  MainNavigationController.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 18/04/2021.
//

import UIKit

class MainNavigationController: UINavigationController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .lightContent
    }
    
    override func loadView() {
        super.loadView()

        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = kMC.Colors.main
        self.navigationBar.backgroundColor = kMC.Colors.main
        self.navigationBar.tintColor = kMC.Colors.Text.onMain
        self.navigationBar.titleTextAttributes = [.foregroundColor: kMC.Colors.Text.onMain]
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
}
