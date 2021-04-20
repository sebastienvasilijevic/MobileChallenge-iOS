//
//  ArtistDetailsViewController.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 18/04/2021.
//

import Cosmos
import Kingfisher
import SnapKit
import UIKit

class ArtistDetailsViewController: MainViewController {
    
    var artistDetailsViewModel: ArtistDetailsViewModel!
    var pageIndex: Int!
    
    private var downloadTask: DownloadTask?
    
    // MARK: - Properties
    
    private lazy var loadingOverlayView: LoadingOverlayView = {
        let v: LoadingOverlayView = .init()
        return v
    }()
    
    private lazy var mainScrollView: UIScrollView = {
        let v: UIScrollView = .init()
        v.backgroundColor = kMC.Colors.Background.primary
        v.alwaysBounceVertical = true
        v.contentInset = .init(top: 0, left: 0, bottom: 2*kMC.UI.margins, right: 0)
        v.addSubview(self.mainStackView)
        return v
    }()
    
    private lazy var mainStackView: UIStackView = {
        let v: UIStackView = .init(arrangedSubviews: [self.artistImageView, self.bodyStackView])
        v.axis = .vertical
        v.alignment = .center
        v.spacing = kMC.UI.margins/2
        return v
    }()
    
    private lazy var bodyStackView: UIStackView = {
        let v: UIStackView = .init()
        v.axis = .vertical
        v.spacing = kMC.UI.margins
        return v
    }()
    
    private lazy var artistImageView: UIImageView = {
        let v: UIImageView = .init()
        v.clipsToBounds = true
        v.contentMode = .scaleAspectFill
        return v
    }()
    
    private lazy var categoryLabel: UILabel = {
        let v: UILabel = .init()
        v.font = kMC.Font.bold.withSize(kMC.Font.defaultSize-1)
        v.textColor = kMC.Colors.Text.secondary
        v.numberOfLines = 1
        v.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return v
    }()
    
    private lazy var countryFlagLabel: UILabel = {
        let v: UILabel = .init()
        v.font = kMC.Font.bold
        v.textColor = kMC.Colors.Text.primary
        v.numberOfLines = 1
        v.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return v
    }()
    
    private lazy var nameLabel: UILabel = {
        let v: UILabel = .init()
        v.font = kMC.Font.bold.withSize(kMC.Font.defaultSize+3)
        v.textColor = kMC.Colors.Text.primary
        v.numberOfLines = 0
        v.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return v
    }()
    
    lazy var descriptionStackView: UIStackView = .init()
    private lazy var descriptionLabel: UILabel = {
        let v: UILabel = .init()
        v.font = kMC.Font.regular.withSize(kMC.Font.defaultSize+1)
        v.textColor = kMC.Colors.Text.primary
        v.numberOfLines = 0
        v.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return v
    }()
    
    lazy var tagsAssociatedTermsStackView: UIStackView = .init()
    private lazy var tagsAssociatedTerms: MCTagsView = {
        let v: MCTagsView = .init()
        v.tagHeight = 24
        return v
    }()
    
    lazy var ratingStarsStackView: UIStackView = .init()
    private lazy var ratingStarsView: CosmosView = {
        let v: CosmosView = .init()
        v.settings.updateOnTouch = false
        v.settings.starSize = 30
        v.settings.fillMode = .precise
        v.settings.textColor = kMC.Colors.Text.primary
        return v
    }()
    
    
    // MARK: - View Life Cycle

    override func loadView() {
        super.loadView()
        
        self.setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureArtistDetailsViewModel()
        self.fetchArtist()
    }
    
    // MARK: - Setup UI
    
    func setupUI() {
        self.view.addSubview(self.mainScrollView)
        self.view.addSubview(self.loadingOverlayView)
        
        let categoryFlagStackView: UIStackView = .init(arrangedSubviews: [self.categoryLabel, self.countryFlagLabel])
        categoryFlagStackView.axis = .horizontal
        categoryFlagStackView.alignment = .top
        categoryFlagStackView.spacing = kMC.UI.margins/2
        bodyStackView.addArrangedSubview(categoryFlagStackView)
        bodyStackView.setCustomSpacing(kMC.UI.margins/2, after: categoryFlagStackView)
        
        bodyStackView.addArrangedSubview(self.nameLabel)
        
        descriptionStackView = self.addStackView(withTitle: "artistDetails_comments_label".localized)
        descriptionStackView.isHidden = true
        descriptionStackView.addArrangedSubview(self.descriptionLabel)
        bodyStackView.addArrangedSubview(descriptionStackView)
        
        tagsAssociatedTermsStackView = self.addStackView(withTitle: "artistDetails_associatedTerms_label".localized)
        tagsAssociatedTermsStackView.isHidden = true
        tagsAssociatedTermsStackView.addArrangedSubview(self.tagsAssociatedTerms)
        bodyStackView.addArrangedSubview(tagsAssociatedTermsStackView)
        
        ratingStarsStackView = self.addStackView(withTitle: "artistDetails_rating_label".localized)
        ratingStarsStackView.isHidden = true
        ratingStarsStackView.addArrangedSubview(self.ratingStarsView)
        bodyStackView.addArrangedSubview(ratingStarsStackView)
        
        
        loadingOverlayView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(100)
        }
        
        mainScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mainStackView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
        }
        
        bodyStackView.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(kMC.UI.margins)
        }
        
        artistImageView.snp.makeConstraints { make in
            make.height.equalTo(artistImageView.snp.width).offset(100)
        }
    }
    
    func addStackView(withTitle title: String) -> UIStackView {
        let label: UILabel = .init()
        label.font = kMC.Font.regular.withSize(kMC.Font.defaultSize-3)
        label.text = title
        label.textColor = kMC.Colors.Text.secondary
        
        let stackView: UIStackView = .init(arrangedSubviews: [label])
        stackView.axis = .vertical
        stackView.spacing = kMC.UI.margins/5
        return stackView
    }
    
    func fillUIData() {
        self.downloadTask?.cancel()
        self.artistImageView.image = UIImage(named: kMC.Images.noPictureImage)
        
        guard let artist = self.artistDetailsViewModel.artist else {
            return
        }
        
        self.downloadTask = self.artistImageView.downloadImage(from: artist.getFirstImageUri(), downsampling: false)
        self.categoryLabel.text = artist.getTypeAndGender()
        self.countryFlagLabel.text = artist.getCountryFlag()
        self.nameLabel.text = artist.name
        self.descriptionLabel.text = artist.disambiguation
        self.descriptionStackView.isHidden = artist.commentsIsEmpty()
        
        if let tags = artist.tags, !tags.nodes.isEmpty {
            for tag in tags.filterAndSort() {
                self.tagsAssociatedTerms.addTag(tag.name)
            }
        }
        self.tagsAssociatedTermsStackView.isHidden = artist.tagsIsEmpty()
        
        if let rating = artist.rating, let value = rating.value {
            ratingStarsView.rating = value
            ratingStarsView.text = artist.getRatingStarsText()
        }
        self.ratingStarsStackView.isHidden = artist.ratingIsEmpty()
    }
    
    // MARK: - Fetch & Update methods
    
    /// Configure Artists ViewModel (auto refresh on data update)
    func configureArtistDetailsViewModel() {
        self.artistDetailsViewModel.onUpdateArtist = { [weak self] in
            self?.loadingOverlayView.stopLoading()
            self?.fillUIData()
        }
    }
    
    /// Fetch artist for artist in viewModel
    func fetchArtist() {
        self.loadingOverlayView.startLoading()
        self.artistDetailsViewModel.fetchArtist(completion: nil)
    }
}
