//
//  MainViewController.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 16/04/2021.
//

import UIKit

class MainViewController: UIViewController {

    override func loadView() {
        super.loadView()
        
        self.navigationController?.navigationBar.barTintColor = kMC.Colors.main
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: kMC.Colors.Text.onMain]
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = .white
        self.view.backgroundColor = kMC.Colors.Background.primary
    }
}
