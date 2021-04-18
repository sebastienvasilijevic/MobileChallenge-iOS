//
//  BookmarksViewController.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 18/04/2021.
//

import UIKit

class BookmarksViewController: CommonArtistListViewController {
    
    lazy var bookmarksViewModel: BookmarksViewModel = .init()
    
    override var hasSupplementaryFooterView: Bool {
        return false
    }
    
    // MARK: - Properties
    
    private lazy var collectionRefreshControl: UIRefreshControl = {
        let v: UIRefreshControl = .init()
        v.addAction(for: .valueChanged) { [weak self] control in
            guard let refreshControl = control as? UIRefreshControl else {
                return
            }
            self?.fetchBookmarks()
            refreshControl.endRefreshing()
        }
        return v
    }()

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchController.searchBar.delegate = self
        self.configureCollectionView()
        self.configureArtistsViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.fetchBookmarks()
    }
    
    // MARK: - CollectionView layout methods
    
    /// Configure CollectionView
    func configureCollectionView() {
        self.artistsCollectionView.delegate = self
        self.artistsCollectionView.refreshControl = self.collectionRefreshControl
    }
    
    /// Configure CollectionView dataSource
    override func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Artist>(collectionView: self.artistsCollectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, artistItem: Artist) -> UICollectionViewCell? in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArtistCell.reuseIdentifer, for: indexPath) as? ArtistCell else { return .init()
            }
            cell.configure(with: artistItem, isBookmarked: true)
            
            cell.bookmarkHandler = { [weak self] cell in
                self?.bookmarksViewModel.bookmarkAction(artist: cell.artist)
                self?.artistsCollectionView.reloadData()
            }
            
            return cell
        }
    }
    
    /// Generate DataSource Snapshot with objects
    override func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Artist>()
        snapshot.appendSections([.artistsList])
        let items = bookmarksViewModel.filteredBookmarks
        snapshot.appendItems(items)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    // MARK: - Fetch & Update methods
    
    /// Configure Bookmarks ViewModel (auto refresh on data update)
    func configureArtistsViewModel() {
        self.bookmarksViewModel.onUpdateBookmarks = { [weak self] in
            self?.updateCollectionView()
        }
    }
    
    /// Fetch bookmarked artists
    func fetchBookmarks() {
        self.bookmarksViewModel.fetchBookmarks(textFilter: self.searchBarText)
    }
}


// MARK: - UISearchBar delegate

extension BookmarksViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Save current text on change to re-assign it later (on EndEditing)
        searchBarText = searchBar.text ?? ""
        
        self.searchBarTextFetch()
    }
    
    func searchBarTextFetch() {
        self.bookmarksViewModel.filterBookmarks(with: searchBarText)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        // Doing it because searchBar is automatically cleared after a search else
        searchBar.text = self.searchBarText
    }
}


// MARK: - UICollectionView delegate

extension BookmarksViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        self.pushArtistDetails(artists: self.bookmarksViewModel.filteredBookmarks, at: indexPath.item)
    }
}
