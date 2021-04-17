//
//  CustomSearchController.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 17/04/2021.
//

import UIKit

class CustomSearchController: UISearchController {
    
    override func loadView() {
        super.loadView()
        
        self.hidesNavigationBarDuringPresentation = false
        self.searchBar.setValue("button_done".localized, forKey: "cancelButtonText")
        
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = kMC.Colors.Background.secondary
            textfield.textColor = kMC.Colors.Text.primary
            textfield.tintColor = kMC.Colors.Text.primary
        }
    }
}
