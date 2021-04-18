//
//  CommonArtistListViewController.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 18/04/2021.
//

import SnapKit
import UIKit

class CommonArtistListViewController: MainViewController {
    
    var searchBarText: String = ""
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Artist>! = nil
    // Change this property in children
    var hasSupplementaryFooterView: Bool {
        return false
    }
    
    enum Section {
        case artistsList
    }
    
    // MARK: - View Life Cycle

    override func loadView() {
        super.loadView()

        self.setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureDataSource()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.updateCollectionViewLayout()
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        self.definesPresentationContext = true
        self.navigationItem.titleView = searchController.searchBar
        
        self.view.addSubview(self.artistsCollectionView)
        
        self.artistsCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Properties
    
    // Using SearchController to get the "done" button when editing searchBar
    lazy var searchController: CustomSearchController = {
        let v: CustomSearchController = .init(searchResultsController: nil)
        // This line to call custom UI in loadView before clicking on it
        _ = v.view
        v.searchBar.placeholder = "artists_list_searchBar_placeholder".localized
        return v
    }()
    
    lazy var artistsCollectionView: UICollectionView = {
        let v = UICollectionView(frame: .init(), collectionViewLayout: self.generateLayout())
        v.alwaysBounceVertical = true
        v.backgroundColor = kMC.Colors.Background.primary
        v.register(ArtistCell.self, forCellWithReuseIdentifier: ArtistCell.reuseIdentifer)
        v.register(LoadingReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: LoadingReusableView.reuseIdentifer)
        return v
    }()
    
    // MARK: - CollectionView layout methods
    
    /// Update CollectionViewLayout (for example on orientation change)
    func updateCollectionViewLayout() {
        self.artistsCollectionView.setCollectionViewLayout(self.generateLayout(), animated: false)
        self.updateCollectionView(reloadingSnapshot: false)
    }
    
    /// Configure CollectionView dataSource
    func configureDataSource() {
        fatalError("Must Override `configureDataSource`")
    }
    
    /// Generate dynamic layout for collectionView
    public func generateLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(200))
        let fullArtistItem = NSCollectionLayoutItem(layoutSize: itemSize)
        fullArtistItem.edgeSpacing = .init(leading: nil, top: .fixed(3), trailing: nil, bottom: .fixed(3))
        
        var numberItemsPerRow: Int = 3
        // If iPad OR isLandcape orientation
        if UIDevice.current.userInterfaceIdiom == .pad || UIDevice.current.orientation.isLandscape {
            numberItemsPerRow = 5
            
            // If iPad + compacted horizontal class (means using 2 apps at the same time on iPad)
            if UIDevice.current.userInterfaceIdiom == .pad && self.traitCollection.horizontalSizeClass == .compact {
                numberItemsPerRow = 3
            }
        }
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: fullArtistItem, count: numberItemsPerRow)
        
        let section = NSCollectionLayoutSection(group: group)
        
        if hasSupplementaryFooterView {
            let footerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
            let footerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerItemSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
            section.boundarySupplementaryItems = [footerItem]
        }
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    /// Generate DataSource Snapshot with objects
    func applySnapshot() {
        fatalError("Must Override `applySnapshot`")
    }
    
    // MARK: - Fetch & Update methods

    /// Update DateSource Snapshot and reload CollectionView
    func updateCollectionView(reloadingSnapshot: Bool = true) {
        if reloadingSnapshot {
            self.applySnapshot()
        }
        self.artistsCollectionView.reloadData()
    }
    
    // MARK: - Push controller
    
    func pushArtistDetails(artists: [Artist], at index: Int) {
        let vc: ArtistDetailsPageViewController = .init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        vc.data = artists
        vc.openedIndex = index
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
