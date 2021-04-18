//
//  BookmarksViewModel.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 18/04/2021.
//

import Foundation

class BookmarksViewModel: NSObject {
    public var onUpdateBookmarks: (() -> Void)?
    
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
    
    
    override init() {
        super.init()
    }
    
    
    public func fetchBookmarks(textFilter: String) {
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
