//
//  ArtistsViewController.swift
//  MobileChallenge
//
//  Created by Taras on 10/03/2021.
//

import Apollo
import CoreData
import SnapKit
import UIKit

class ArtistsViewController: CommonArtistListViewController {
    
    private let numberItemPerPage: Int = 15
    
    lazy var artistsViewModel: ArtistsViewModel = .init()
    
    var alreadyFetchingFromScrollBottom: Bool = false
    override var hasSupplementaryFooterView: Bool {
        return true
    }
    
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchController.searchBar.delegate = self
        self.refreshBackgroundView()
        self.configureCollectionView()
        self.configureArtistsViewModel()
    }
    
    
    // MARK: - CollectionView layout methods
    
    /// Configure CollectionView
    func configureCollectionView() {
        self.artistsCollectionView.delegate = self
        self.artistsCollectionView.showBackgroundView()
    }
    
    /// Configure Collection BackgroundView
    override func configurePlaceholderView() {
        self.placeholderCollectionView.addButton(icon: UIImage(systemName: kMC.Images.magnifyingglass), title: "artists_list_placeholder_button_text".localized, type: .primary) { [weak self] placeholderView in
            self?.searchController.searchBar.becomeFirstResponder()
        }
    }
    
    /// Refresh CollectionView BackgroundView
    public func refreshBackgroundView() {
        super.refreshCollectionBackgroundView(emptyBarImg: kMC.Images.magnifyingglass,
                                             emptyBarText: "artists_list_placeholder_searchArtist_search_text".localized,
                                             notFoundImg: kMC.Images.personCircleXmark,
                                             notFoundText: String(format: "artists_list_placeholder_noArtist_search_text".localized, self.searchBarText))
    }
    
    /// Configure CollectionView dataSource
    override func configureDataSource() {
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
    override func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Artist>()
        snapshot.appendSections([.artistsList])
        let items = artistsViewModel.artists
        snapshot.appendItems(items)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    
    // MARK: - Fetch & Update methods
    
    /// Configure Artists ViewModel (auto refresh on data update)
    func configureArtistsViewModel() {
        self.artistsViewModel.onUpdateArtists = { [weak self] in
            self?.updateCollectionView()
        }
    }
    
    /// Fetch artists for a `isNewList`
    ///
    /// - Parameter isNewList: If true, the current collectionView is cleared before fetching.
    /// - Parameter completion: The callback to execute after fetch has done.
    func fetchArtists(isNewList: Bool, completion: (() -> Void)? = nil) {
        self.artistsViewModel.fetchArtists(query: self.searchBarText, first: self.numberItemPerPage, isNewList: isNewList) { (result, error) in
            completion?()
        }
    }
}

// MARK: - UISearchBar delegate

extension ArtistsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Save current text on change to re-assign it later (on EndEditing)
        searchBarText = searchBar.text ?? ""
        
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.searchBarTextFetch), object: nil)
        self.perform(#selector(self.searchBarTextFetch), with: nil, afterDelay: 0.3)
    }
    
    @objc func searchBarTextFetch() {
        self.loadingOverlayView.startLoading()
        self.searchController.isLoading = true
        self.artistsCollectionView.hideBackgroundView()
        self.fetchArtists(isNewList: true) { [weak self] in
            self?.loadingOverlayView.stopLoading()
            self?.searchController.isLoading = false
            if self?.artistsViewModel.artists.isEmpty ?? true {
                self?.refreshBackgroundView()
                self?.artistsCollectionView.showBackgroundView()
            }
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        // Doing it because searchBar is automatically cleared after a search else
        searchBar.text = self.searchBarText
    }
}


// MARK: - UICollectionView delegate

extension ArtistsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == self.artistsViewModel.artists.count-3 && !self.alreadyFetchingFromScrollBottom && self.artistsViewModel.hasNextPage {
            self.alreadyFetchingFromScrollBottom = true
            self.fetchArtists(isNewList: false) { [weak self] in
                self?.alreadyFetchingFromScrollBottom = false
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
        
        self.presentArtistDetails(artists: self.artistsViewModel.artists, at: indexPath.item)
    }
}
