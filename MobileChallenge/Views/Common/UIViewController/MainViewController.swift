//
//  MainViewController.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 16/04/2021.
//

import UIKit

class MainViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func loadView() {
        super.loadView()
        
        self.view.backgroundColor = kMC.Colors.Background.primary
    }
}
