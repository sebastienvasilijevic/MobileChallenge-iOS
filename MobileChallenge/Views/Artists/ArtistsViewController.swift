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
        
        self.setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureDataSource()
        self.configureArtistsViewModel()
        self.fetchArtists(newList: true)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.updateCollectionViewLayout()
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
        let v = UICollectionView(frame: .init(), collectionViewLayout: self.generateLayout())
        v.backgroundColor = kMC.Colors.Background.primary
        v.delegate = self
        v.register(ArtistCell.self, forCellWithReuseIdentifier: ArtistCell.reuseIdentifer)
        v.register(LoadingReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: LoadingReusableView.reuseIdentifer)
        return v
    }()
    
    // MARK: Setup UI
    
    private func setupUI() {
        self.definesPresentationContext = true
        self.navigationItem.titleView = searchController.searchBar
        
        self.view.addSubview(self.artistsCollectionView)
        
        self.artistsCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
    // MARK: CollectionView layout methods
    
    /// Update CollectionViewLayout (for example on orientation change)
    func updateCollectionViewLayout() {
        self.artistsCollectionView.setCollectionViewLayout(self.generateLayout(), animated: false)
        self.updateCollectionView(reloadingSnapshot: false)
    }
    
    /// Configure CollectionView dataSource
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Artist>(collectionView: self.artistsCollectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, artistItem: Artist) -> UICollectionViewCell? in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArtistCell.reuseIdentifer, for: indexPath) as? ArtistCell else { return .init()
            }
            cell.configure(with: artistItem, isBookmarked: self.artistsViewModel.isArtistBookmarked(artist: artistItem))
            
            cell.bookmarkHandler = { [weak self] cell in
                self?.artistsViewModel.bookmarkAction(artist: cell.artist)
                self?.artistsCollectionView.reloadData()
            }
            
            return cell
        }
        
        dataSource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            
            guard let loadingView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LoadingReusableView.reuseIdentifer, for: indexPath) as? LoadingReusableView else {
                
                return .init()
            }
            
            return loadingView
        }
    }
    
    /// Generate DataSource Snapshot with objects
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Artist>()
        snapshot.appendSections([.artistsList])
        let items = artistsViewModel.artists
        snapshot.appendItems(items)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    
    // MARK: Fetch & Update methods
    
    /// Configure Artists ViewModel (auto refresh on data update)
    func configureArtistsViewModel() {
        self.artistsViewModel.onUpdateArtists = { [weak self] in
            self?.updateCollectionView()
        }
    }
    
    /// Fetch artists for a `newList`
    ///
    /// - Parameter newList: If true, the current collectionView is cleared before fetching.
    /// - Parameter completion: The callback to execute after fetch has done.
    func fetchArtists(newList: Bool, completion: (() -> Void)? = nil) {
        self.artistsViewModel.fetchArtists(query: self.searchController.searchBar.text, first: self.numberItemPerPage, newList: newList) { (result, error) in
            completion?()
        }
    }

    /// Update DateSource Snapshot and reload CollectionView
    func updateCollectionView(reloadingSnapshot: Bool = true) {
        if reloadingSnapshot {
            self.applySnapshot()
        }
        self.artistsCollectionView.reloadData()
    }
}

// MARK: - UISearchBar delegate

extension ArtistsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.searchBarTextFetch), object: nil)
        self.perform(#selector(self.searchBarTextFetch), with: nil, afterDelay: 0.3)
        
        // Save current text on change to re-assign it later (on EndEditing)
        searchBarTerms = searchBar.text ?? ""
    }
    
    @objc func searchBarTextFetch() {
        self.searchController.isLoading = true
        self.fetchArtists(newList: true) {
            self.searchController.isLoading = false
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        // Doing it because searchBar is automatically cleared after a search else
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
        if elementKind == UICollectionView.elementKindSectionFooter, let loadingView = view as? LoadingReusableView, self.artistsViewModel.hasNextPage {
            loadingView.startAnimating()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter, let loadingView = view as? LoadingReusableView {
            loadingView.stopAnimating()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
