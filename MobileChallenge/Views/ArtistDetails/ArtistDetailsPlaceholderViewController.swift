//
//  ArtistDetailsPlaceholderViewController.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 21/04/2021.
//

import UIKit

class ArtistDetailsPlaceholderViewController: MainViewController {
    
    // MARK: - Properties
    
    private lazy var placeholderView: PlaceholderView = {
        let imageConfiguration = UIImage.SymbolConfiguration(weight: .bold)
        let image = UIImage(systemName: kMC.Images.personCircleQuestionmark, withConfiguration: imageConfiguration)?.withTintColor(kMC.Colors.grayLight.withAlphaComponent(0.7), renderingMode: .alwaysOriginal)
        
        let v: PlaceholderView = .init(frame: .zero, image: image, text: "artist_details_placeholder_text".localized)
        v.textLabel.textColor = kMC.Colors.Text.primary.withAlphaComponent(0.7)
        return v
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return (self.view.backgroundColor?.isLight() ?? true) ? .darkContent : .lightContent
    }
    
    // MARK: - View Life Cycle
    
    override func loadView() {
        super.loadView()
        
        self.setupUI()
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        view.addSubview(placeholderView)
        
        placeholderView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
