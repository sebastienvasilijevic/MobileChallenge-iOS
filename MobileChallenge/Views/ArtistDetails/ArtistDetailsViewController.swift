//
//  ArtistDetailsViewController.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 18/04/2021.
//

import Kingfisher
import SnapKit
import UIKit

class ArtistDetailsViewController: MainViewController {
    
    lazy var artistDetailsViewModel: ArtistDetailsViewModel = .init()
    
    var data: Artist!
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
        let categoryFlagStackView: UIStackView = .init(arrangedSubviews: [self.categoryLabel, self.countryFlagLabel])
        categoryFlagStackView.axis = .horizontal
        categoryFlagStackView.alignment = .top
        categoryFlagStackView.spacing = kMC.UI.margins/2
        
        let v: UIStackView = .init(arrangedSubviews: [categoryFlagStackView, self.nameLabel, self.descriptionLabel])
        v.axis = .vertical
        v.spacing = kMC.UI.margins
        v.setCustomSpacing(kMC.UI.margins/2, after: categoryFlagStackView)
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
    
    private lazy var descriptionLabel: UILabel = {
        let v: UILabel = .init()
        v.font = kMC.Font.regular.withSize(kMC.Font.defaultSize+1)
        v.textColor = kMC.Colors.Text.primary
        v.numberOfLines = 0
        v.setContentHuggingPriority(.defaultHigh, for: .vertical)
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
        self.fetchArtists(id: data.id)
    }
    
    // MARK: - Setup UI
    
    func setupUI() {
        self.view.addSubview(self.mainScrollView)
        self.view.addSubview(self.loadingOverlayView)
        
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
    
    func fillUIData() {
        self.loadingOverlayView.stopLoading()
        self.downloadTask?.cancel()
        self.artistImageView.image = UIImage(named: kMC.Images.noPictureImage)
        
        guard let artist = data else {
            return
        }
        
        self.downloadTask = self.artistImageView.downloadImage(from: artist.getFirstImageUri(), downsampling: false)
        self.categoryLabel.text = artist.type + " " + (artist.getReadableGender().isEmpty ? "" : "(\(artist.getReadableGender()))")
        self.countryFlagLabel.text = artist.getCountryFlag()
        self.nameLabel.text = artist.name
        self.descriptionLabel.text = artist.disambiguation
    }
    
    // MARK: - Fetch & Update methods
    
    /// Configure Artists ViewModel (auto refresh on data update)
    func configureArtistDetailsViewModel() {
        self.artistDetailsViewModel.onUpdateArtist = { [weak self] in
            self?.fillUIData()
        }
    }
    
    /// Fetch artists for `id`
    ///
    /// - Parameter id: The artist ID to fetch.
    func fetchArtists(id: String) {
        self.loadingOverlayView.startLoading()
        self.artistDetailsViewModel.fetchArtists(id: id, completion: nil)
    }
}
