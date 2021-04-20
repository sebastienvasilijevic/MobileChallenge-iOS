//
//  MCTagCollectionViewCell.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 20/04/2021.
//

import SnapKit
import UIKit

class MCTagCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TagCollectionViewCell"
    
    // MARK: - Properties
    
    public var tagHeight: CGFloat = 0 {
        didSet {
            self.contentView.layer.cornerRadius = self.tagHeight/2
            
            self.mainLabel.snp.updateConstraints { make in
                make.height.equalTo(self.tagHeight)
            }
        }
    }
    
    private(set) lazy var mainLabel: UILabel = {
        let v: UILabel = .init()
        v.font = kMC.Font.regular.withSize(kMC.Font.defaultSize-2)
        v.text = ""
        v.textColor = kMC.Colors.Text.onMain
        v.textAlignment = .center
        return v
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    // MARK: - Setup UI
    
    func setupUI() {
        self.clipsToBounds = true
        self.contentView.backgroundColor = kMC.Colors.main
        
        contentView.addSubview(mainLabel)
        
        mainLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(kMC.UI.margins/3)
            make.centerY.equalToSuperview()
            make.height.equalTo(tagHeight)
        }
    }
    
    func configure(withText text: String) {
        self.mainLabel.text = text
    }
}
