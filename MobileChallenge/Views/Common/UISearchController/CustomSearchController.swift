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
        
        self.obscuresBackgroundDuringPresentation = false
        self.hidesNavigationBarDuringPresentation = false
        self.searchBar.setValue("artists_list_searchBar_button_done".localized, forKey: "cancelButtonText")
        
        if let textfield = searchBar.textField {
            textfield.backgroundColor = kMC.Colors.Background.secondary
            textfield.textColor = kMC.Colors.Text.primary
            textfield.tintColor = kMC.Colors.Text.primary
        }
    }
    
    public var isLoading: Bool = false {
        didSet {
            self.searchBar.isLoading = self.isLoading
        }
    }
}
