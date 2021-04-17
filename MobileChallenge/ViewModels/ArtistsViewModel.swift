//
//  ArtistsViewModel.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 16/04/2021.
//

import Apollo
import Foundation

class ArtistsViewModel: NSObject {
    private(set) var artists: Artists = []
    private(set) var hasNextPage: Bool = false
    private var lastCursorId: String? = nil
    
    private var cancellableFetch: Cancellable?
    
    override init() {
        super.init()
    }
    
    init(artists: Artists) {
        super.init()
        self.artists = artists
    }
    
    public func fetchArtists(query: String?, first: Int, newList: Bool, completion: @escaping (GraphQLResult<ArtistsQuery.Data>?, Error?) -> Void) {
        self.cancellableFetch?.cancel()
        self.cancellableFetch = nil
        
        if newList {
            self.artists.removeAll()
            self.hasNextPage = false
            self.lastCursorId = nil
        }
        
        let lastQuery: String = (query == nil || query!.isEmpty) ? "*" : "\"\(query!)\""
        let artistsQuery = ArtistsQuery(search: lastQuery, first: first, after: lastCursorId)
        
        self.cancellableFetch = Network.shared.apollo.fetch(query: artistsQuery) { result in
            switch result {
            case .success(let graphQLResult):
                if let artistsNodes = graphQLResult.data?.search?.artists?.nodes {
                    self.artists.append(contentsOf: artistsNodes.compactMap{ $0 })
                }
                if let pageInfo = graphQLResult.data?.search?.artists?.pageInfo {
                    self.hasNextPage = pageInfo.hasNextPage
                    self.lastCursorId = pageInfo.endCursor
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
}
