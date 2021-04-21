//
//  BookmarksViewModel.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 18/04/2021.
//

import Foundation

class BookmarksViewModel: NSObject {
    public var onUpdateBookmarks: (() -> Void)?
    
    private var textFilter: String = ""
    
    private var artistBookmarkObserver: NSObjectProtocol?
    
    private(set) var bookmarks: [Artist] = [] {
        didSet {
            self.filteredBookmarks = self.bookmarks
        }
    }
    
    private(set) var filteredBookmarks: [Artist] = [] {
        didSet {
            self.onUpdateBookmarks?()
        }
    }
    
    
    deinit {
        if let artistBookmarkObserver = self.artistBookmarkObserver {
            NotificationCenter.default.removeObserver(artistBookmarkObserver, name: ArtistsData.bookmarkDidChange, object: nil)
        }
    }
    
    override init() {
        super.init()
        
        self.artistBookmarkObserver = NotificationCenter.default.addObserver(forName: ArtistsData.bookmarkDidChange, object: nil, queue: nil, using: { [weak self] (data) in
            if let textFilter = self?.textFilter {
                self?.fetchBookmarks(textFilter: textFilter)
            }
        })
    }
    
    
    public func fetchBookmarks(textFilter: String) {
        self.textFilter = textFilter
        
        // Convert ArtistLocal (from CoreData) to project Artist object
        self.bookmarks = ArtistsData.shared.all().map({ Artist(artistLocal: $0) })
        
        self.filterBookmarks(with: textFilter)
    }
    
    public func filterBookmarks(with text: String) {
        if text.isEmpty {
            self.filteredBookmarks = self.bookmarks
            
        } else {
            self.filteredBookmarks = bookmarks.filter { (($0.name ?? "").contains(text) || ($0.disambiguation ?? "").contains(text)) }
        }
    }
    
    public func bookmarkAction(artist: Artist) {
        return ArtistsData.shared.bookmarkAction(artist: artist)
    }
}
