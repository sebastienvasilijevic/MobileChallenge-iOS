//
//  ArtistsViewModel.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 16/04/2021.
//

import Apollo
import Foundation

class ArtistsViewModel: NSObject {
    public var onUpdateArtists: (() -> Void)?
    
    private var artistBookmarkObserver: NSObjectProtocol?
    
    private(set) var artists: [Artist] = []
    
    private(set) var hasNextPage: Bool = false
    private var lastCursorId: String? = nil
    
    private var cancellableFetch: Cancellable?
    
    deinit {
        if let artistBookmarkObserver = self.artistBookmarkObserver {
            NotificationCenter.default.removeObserver(artistBookmarkObserver, name: ArtistsData.bookmarkDidChange, object: nil)
        }
    }
    
    override init() {
        super.init()
        
        self.artistBookmarkObserver = NotificationCenter.default.addObserver(forName: ArtistsData.bookmarkDidChange, object: nil, queue: nil, using: { [weak self] (data) in
            self?.onUpdateArtists?()
        })
    }
    
    convenience init(artists: [Artist]) {
        self.init()
        self.artists = artists
    }
    
    public func fetchArtists(query: String, first: Int, isNewList: Bool, completion: @escaping (GraphQLResult<ArtistsQuery.Data>?, Error?) -> Void) {
        self.cancellableFetch?.cancel()
        self.cancellableFetch = nil
        
        if isNewList {
            self.hasNextPage = false
            self.lastCursorId = nil
            self.artists.removeAll()
        }
        
        let artistsQuery = ArtistsQuery(search: "\"\(query)\"", first: first, after: lastCursorId)
        
        self.cancellableFetch = Network.shared.apollo.fetch(query: artistsQuery) { result in
            switch result {
            case .success(let graphQLResult):
                DispatchQueue.main.async {
                    if let pageInfo = graphQLResult.data?.search?.artists?.pageInfo {
                        self.hasNextPage = pageInfo.hasNextPage
                        self.lastCursorId = pageInfo.endCursor
                    }
                    if let artistsNodes = graphQLResult.data?.search?.artists?.nodes {
                        // Convert apiArtist to project object Artist
                        let mArtists: [Artist] = artistsNodes.compactMap({ $0 }).map({ Artist(apiArtistNode: $0) })
                        self.artists.append(contentsOf: mArtists)
                    } else {
                        self.artists.removeAll()
                    }
                    self.onUpdateArtists?()
                    completion(graphQLResult, nil)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.onUpdateArtists?()
                    completion(nil, error)
                }
            }
        }
    }
    
    public func isArtistBookmarked(artist: Artist) -> Bool {
        return ArtistsData.shared.isBookmarked(artist: artist)
    }
    
    public func bookmarkAction(artist: Artist) {
        return ArtistsData.shared.bookmarkAction(artist: artist)
    }
}
