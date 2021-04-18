//
//  ArtistDetailsViewModel.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 18/04/2021.
//

import Apollo
import Foundation

class ArtistDetailsViewModel: NSObject {
    public var onUpdateArtist: (() -> Void)?
    
    private(set) var artist: Artist! {
        didSet {
            self.onUpdateArtist?()
        }
    }
    
    private var cancellableFetch: Cancellable?
    
    override init() {
        super.init()
    }
    
    public func fetchArtists(id: String, completion: ((GraphQLResult<ArtistDetailsQuery.Data>?, Error?) -> Void)?) {
        self.cancellableFetch?.cancel()
        self.cancellableFetch = nil
        
        let artistDetailsQuery = ArtistDetailsQuery(id: id)
        
        self.cancellableFetch = Network.shared.apollo.fetch(query: artistDetailsQuery) { result in
            switch result {
            case .success(let graphQLResult):
                DispatchQueue.main.async {
                    if let artistDetailsNode = graphQLResult.data?.node?.asArtist {
                        self.artist = .init(apiArtistDetailsNode: artistDetailsNode)
                    }
                    completion?(graphQLResult, nil)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion?(nil, error)
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