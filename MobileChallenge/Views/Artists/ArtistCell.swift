//
//  ArtistCell.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 17/04/2021.
//

import Kingfisher
import SnapKit
import UIKit

class ArtistCell: UICollectionViewCell {
    static let reuseIdentifer: String = "artistCellReuseIdentifier"
    
    public var bookmarkHandler: ((ArtistCell) -> Void)?
    
    private var downloadTask: DownloadTask?
    
    private(set) var artist: Artist! {
        didSet {
            self.configureCell()
        }
    }
    private(set) var isBookmarked: Bool = false {
        didSet {
            self.configureBookmarkButton()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.artist = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.1, delay: 0.0, options: [.curveEaseInOut,.allowUserInteraction], animations: {
                
                self.transform = self.isHighlighted ? .init(scaleX: 0.95, y: 0.95) : .identity
                
            }, completion: nil)
        }
    }
    
    // MARK: Init views
    
    private lazy var mainView: UIView = {
        let v: UIView = .init()
        v.clipsToBounds = true
        v.addSubview(self.contentStackView)
        return v
    }()
    
    private lazy var contentStackView: UIStackView = {
        let v: UIStackView = .init(arrangedSubviews: [self.imageView, self.categoryFlagStackView, self.nameLabel, self.descriptionLabel])
        v.axis = .vertical
        v.spacing = kMC.UI.margins/5
        return v
    }()
    
    private lazy var imageView: UIImageView = {
        let v: UIImageView = .init()
        v.isUserInteractionEnabled = true
        v.clipsToBounds = true
        v.contentMode = .scaleAspectFill
        v.layer.cornerRadius = 10
        return v
    }()
    
    private lazy var bookmarkButton: ShadowButton = {
        let v: ShadowButton = .init(type: .custom)
        v.addAction(for: .touchUpInside) { button in
            self.configureBookmarkButton()
            self.bookmarkHandler?(self)
        }
        return v
    }()
    
    private lazy var categoryFlagStackView: UIStackView = {
        let v: UIStackView = .init(arrangedSubviews: [self.categoryLabel, self.countryFlagLabel])
        v.axis = .horizontal
        v.alignment = .top
        v.spacing = kMC.UI.margins/2
        return v
    }()
    
    internal lazy var categoryLabel: UILabel = {
        let v: UILabel = .init()
        v.font = kMC.Font.bold.withSize(kMC.Font.defaultSize-3)
        v.textColor = kMC.Colors.Text.secondary
        v.numberOfLines = 1
        v.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return v
    }()
    
    internal lazy var countryFlagLabel: UILabel = {
        let v: UILabel = .init()
        v.font = kMC.Font.bold
        v.textColor = kMC.Colors.Text.primary
        v.numberOfLines = 1
        v.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return v
    }()
    
    internal lazy var nameLabel: UILabel = {
        let v: UILabel = .init()
        v.font = kMC.Font.bold
        v.numberOfLines = 2
        return v
    }()
    
    internal lazy var descriptionLabel: UILabel = {
        let v: UILabel = .init()
        v.font = kMC.Font.regular
        v.textColor = kMC.Colors.Text.secondary
        v.numberOfLines = 2
        return v
    }()
}


// MARK: - Setup UI

extension ArtistCell {
    func setupUI() {
        let selectedBackgroundView: UIView = .init()
        selectedBackgroundView.clipsToBounds = true
        selectedBackgroundView.backgroundColor = kMC.Colors.highlight.withAlphaComponent(0.1)
        selectedBackgroundView.layer.cornerRadius = 10
        self.selectedBackgroundView = selectedBackgroundView
        
        self.clipsToBounds = true
        
        self.contentView.addSubview(mainView)
        
        self.imageView.addSubview(self.bookmarkButton)
        
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
        
        contentStackView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(self.mainView.snp.width).offset(20)
        }
        
        bookmarkButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(5)
        }
        
        categoryFlagStackView.snp.makeConstraints { make in
            make.height.equalTo(10)
        }
    }
    
    public func configure(with artist: Artist!, isBookmarked: Bool) {
        self.artist = artist
        self.isBookmarked = isBookmarked
    }
    
    /// Configuration of the cell, called in artist didSet
    private func configureCell() {
        let placeholderImage: UIImage? = UIImage(named: kMC.Images.noPictureImage)
        
        self.downloadTask?.cancel()
        self.downloadTask = nil
        self.imageView.image = placeholderImage
        self.bookmarkButton.isHidden = true
        self.categoryLabel.text = ""
        self.countryFlagLabel.text = ""
        self.nameLabel.text = ""
        self.descriptionLabel.text = ""
        
        guard let value = artist else {
            return
        }
        
        if let firstImage = value.getMediaImages().first, let url = URL(string: firstImage.url) {
            self.imageView.layoutIfNeeded()
            self.imageView.kf.indicatorType = .activity
            
            self.downloadTask = self.imageView.kf.setImage(
                with: url,
                placeholder: placeholderImage,
                options: [
                    .processor(DownsamplingImageProcessor(size: self.imageView.bounds.size)),
                    .scaleFactor(UIScreen.main.scale),
                    .cacheOriginalImage,
                    .loadDiskFileSynchronously
                ]
            )
        }
        self.configureBookmarkButton()
        self.categoryLabel.text = value.type ?? ""
        self.countryFlagLabel.text = value.getCountryFlag()
        self.nameLabel.text = value.name ?? ""
        self.descriptionLabel.text = value.disambiguation ?? ""
    }
    
    private func configureBookmarkButton() {
        self.bookmarkButton.isHidden = false
        var bookmarkImageName: String = kMC.Images.bookmark
        if self.isBookmarked {
            bookmarkImageName = kMC.Images.bookmarkFill
        }
        let bookmarkImageConfiguration = UIImage.SymbolConfiguration(weight: .bold)
        let bookmarkImage = UIImage(systemName: bookmarkImageName, withConfiguration: bookmarkImageConfiguration)?.withTintColor(kMC.Colors.main, renderingMode: .alwaysOriginal)
        self.bookmarkButton.setImage(bookmarkImage, for: .normal)
    }
}

