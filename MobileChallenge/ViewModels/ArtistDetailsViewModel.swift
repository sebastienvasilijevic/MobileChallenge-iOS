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
    
    private var artistBookmarkObserver: NSObjectProtocol?
    
    private(set) var artist: Artist! {
        didSet {
            self.onUpdateArtist?()
        }
    }
    
    private var cancellableFetch: Cancellable?
    
    deinit {
        if let artistBookmarkObserver = self.artistBookmarkObserver {
            NotificationCenter.default.removeObserver(artistBookmarkObserver, name: ArtistsData.bookmarkDidChange, object: nil)
        }
    }
    
    override init() {
        super.init()
        
        self.artistBookmarkObserver = NotificationCenter.default.addObserver(forName: ArtistsData.bookmarkDidChange, object: nil, queue: nil, using: { [weak self] (data) in
            self?.onUpdateArtist?()
        })
    }
    
    convenience init(artist: Artist!) {
        self.init()
        self.artist = artist
    }
    
    public func fetchArtist(completion: ((GraphQLResult<ArtistDetailsQuery.Data>?, Error?) -> Void)?) {
        self.cancellableFetch?.cancel()
        self.cancellableFetch = nil
        
        guard let _artist = self.artist else {
            return
        }
        
        let artistDetailsQuery = ArtistDetailsQuery(id: _artist.id)
        
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
    
    public func isArtistBookmarked() -> Bool {
        return ArtistsData.shared.isBookmarked(artist: artist)
    }
    
    public func bookmarkAction() {
        return ArtistsData.shared.bookmarkAction(artist: artist)
    }
}
