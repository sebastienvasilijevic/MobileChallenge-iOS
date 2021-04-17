//
//  ArtistsViewController.swift
//  MobileChallenge
//
//  Created by Taras on 10/03/2021.
//

import Apollo
import SnapKit
import UIKit

class ArtistsViewController: MainViewController {
    
    private let numberItemPerPage: Int = 15
    
    lazy var artistsViewModel: ArtistsViewModel = .init()
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Artist>! = nil
    
    var searchBarTerms: String = ""
    var alreadyFetchingFromScrollBottom: Bool = false
    
    enum Section {
        case artistsList
    }
    
    // MARK: Load methods

    override func loadView() {
        super.loadView()
        
        self.setupViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureDataSource()
        self.fetchArtists(newList: true)
    }
    
    private func setupViews() {
        self.definesPresentationContext = true
        self.navigationItem.titleView = searchController.searchBar
        
        self.view.addSubview(self.artistsCollectionView)
        
        self.artistsCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: Update methods
    
    func fetchArtists(newList: Bool, completion: (() -> Void)? = nil) {
        artistsViewModel.fetchArtists(query: self.searchController.searchBar.text, first: self.numberItemPerPage, newList: newList) { [weak self] (result, error) in
            completion?()
            self?.updateCollectionView()
        }
    }

    func updateCollectionView() {
        self.applySnapshot()
        
        self.artistsCollectionView.reloadData()
    }
    
    
    // MARK: Init views
    
    // Using SearchController to get the "done" button when editing searchBar
    private lazy var searchController: CustomSearchController = {
        let v: CustomSearchController = .init(searchResultsController: nil)
        // This line to call custom UI in loadView before clicking on it
        _ = v.view
        v.searchBar.placeholder = "artists_list_searchBar_placeholder".localized
        v.searchBar.delegate = self
        return v
    }()
    
    private lazy var artistsCollectionView: UICollectionView = {
        let v = UICollectionView(frame: .init(), collectionViewLayout: generateLayout())
        v.backgroundColor = kMC.Colors.Background.primary
        v.delegate = self
        v.register(ArtistCell.self, forCellWithReuseIdentifier: ArtistCell.reuseIdentifer)
        v.register(LoadingReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: LoadingReusableView.reuseIdentifer)
        return v
    }()
    
    
    // MARK: CollectionView layout methods
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Artist>(collectionView: self.artistsCollectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, detailItem: Artist) -> UICollectionViewCell? in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArtistCell.reuseIdentifer, for: indexPath) as? ArtistCell else { return .init()
            }
            cell.configure(with: detailItem)
            
            return cell
        }
        
        dataSource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            
            guard let loadingView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LoadingReusableView.reuseIdentifer, for: indexPath) as? LoadingReusableView else {
                
                return .init()
            }
            
            return loadingView
        }
    }
    
    func generateLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(200))
        let fullPhotoItem = NSCollectionLayoutItem(layoutSize: itemSize)
        fullPhotoItem.edgeSpacing = .init(leading: nil, top: .fixed(3), trailing: nil, bottom: .fixed(3))
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: fullPhotoItem, count: UIDevice.current.userInterfaceIdiom == .pad ? 5 : 3)
        
        let section = NSCollectionLayoutSection(group: group)
        
        let footerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
        let footerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerItemSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
        section.boundarySupplementaryItems = [footerItem]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Artist>()
        snapshot.appendSections([.artistsList])
        let items = artistsViewModel.artists
        snapshot.appendItems(items)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: - UISearchBar delegate

extension ArtistsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.searchBarTextFetch), object: nil)
        self.perform(#selector(self.searchBarTextFetch), with: nil, afterDelay: 0.3)
        
        searchBarTerms = searchBar.text ?? ""
    }
    
    @objc func searchBarTextFetch() {
        self.fetchArtists(newList: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        // Doing it because searchBar is automatically cleared else
        searchBar.text = self.searchBarTerms
    }
}


// MARK: - UICollectionView delegate

extension ArtistsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == self.artistsViewModel.artists.count-3 && !self.alreadyFetchingFromScrollBottom && self.artistsViewModel.hasNextPage {
            self.alreadyFetchingFromScrollBottom = true
            self.fetchArtists(newList: false) {
                self.alreadyFetchingFromScrollBottom = false
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter, let loadingView = view as? LoadingReusableView {
            loadingView.startAnimating()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter, let loadingView = view as? LoadingReusableView {
            loadingView.startAnimating()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
