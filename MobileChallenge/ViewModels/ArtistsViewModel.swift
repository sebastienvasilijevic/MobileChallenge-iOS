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
    
    private(set) var artists: [Artist] = [] {
        didSet {
            self.onUpdateArtists?()
        }
    }
    private(set) var hasNextPage: Bool = false
    private var lastCursorId: String? = nil
    
    private var cancellableFetch: Cancellable?
    
    override init() {
        super.init()
    }
    
    init(artists: [Artist]) {
        super.init()
        self.artists = artists
    }
    
    public func fetchArtists(query: String?, first: Int, newList: Bool, completion: @escaping (GraphQLResult<ArtistsQuery.Data>?, Error?) -> Void) {
        self.cancellableFetch?.cancel()
        self.cancellableFetch = nil
        
        if newList {
            self.hasNextPage = false
            self.lastCursorId = nil
            self.artists.removeAll()
        }
        
        let lastQuery: String = (query == nil || query!.isEmpty) ? "*" : "\"\(query!)\""
        let artistsQuery = ArtistsQuery(search: lastQuery, first: first, after: lastCursorId)
        
        self.cancellableFetch = Network.shared.apollo.fetch(query: artistsQuery) { result in
            switch result {
            case .success(let graphQLResult):
                if let pageInfo = graphQLResult.data?.search?.artists?.pageInfo {
                    self.hasNextPage = pageInfo.hasNextPage
                    self.lastCursorId = pageInfo.endCursor
                }
                if let artistsNodes = graphQLResult.data?.search?.artists?.nodes {
                    var mArtists: [Artist] = []
                    for artistNode in artistsNodes.compactMap({ $0 }) {
                        mArtists.append(.init(apiArtistNode: artistNode))
                    }
                    self.artists.append(contentsOf: mArtists)
                }
                DispatchQueue.main.async {
                    completion(graphQLResult, nil)
                }
            case .failure(let error):
                DispatchQueue.main.async {
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
