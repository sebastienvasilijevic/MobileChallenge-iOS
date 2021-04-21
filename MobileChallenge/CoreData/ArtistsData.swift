//
//  ArtistsData.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 18/04/2021.
//

import CoreData

class ArtistsData {
    static let bookmarkDidChange = Notification.Name("bookmarkDidChange")
    static let artistObject = "artistObject"
    static let artistIsBookmarked = "isBookmarked"
    
    static let shared = ArtistsData()
    
    public func all() -> [ArtistLocal] {
        let request: NSFetchRequest<ArtistLocal> = ArtistLocal.fetchRequest()
        
        guard let artistsLocalArray = try? DB.shared.viewContext.fetch(request) else { return [] }
        
        return artistsLocalArray
    }
    
    public func isBookmarked(artist: Artist!) -> Bool {
        if artist == nil {
            return false
        }
        
        let request: NSFetchRequest<ArtistLocal> = ArtistLocal.fetchRequest()
        
        request.predicate = NSPredicate(format: "%K == %@", argumentArray: ["mbid", artist.mbid as String])
        
        guard let artistsLocalArray = try? DB.shared.viewContext.fetch(request) else { return false }
        
        return !artistsLocalArray.isEmpty
    }
    
    public func bookmarkAction(artist _artist: Artist!) {
        guard let artist = _artist else {
            return
        }
        
        if isBookmarked(artist: artist) {
            self.unbookmarkArtist(artist: artist)
            NotificationCenter.default.post(name: ArtistsData.bookmarkDidChange, object: self, userInfo: [ArtistsData.artistIsBookmarked: false,
                                                                                                          ArtistsData.artistObject: artist])
            
        } else {
            self.bookmarkArtist(artist: artist)
            NotificationCenter.default.post(name: ArtistsData.bookmarkDidChange, object: self, userInfo: [ArtistsData.artistIsBookmarked: true,
                                                                                                          ArtistsData.artistObject: artist])
        }
    }
    
    private func bookmarkArtist(artist _artist: Artist!) {
        guard let artist = _artist else {
            return
        }
        
        let artistLocal = ArtistLocal(context: DB.shared.viewContext)
        artistLocal.configure(with: artist)
        DB.shared.saveContext()
    }
    
    private func unbookmarkArtist( artist _artist: Artist!) {
        guard let artist = _artist else {
            return
        }
        
        let request: NSFetchRequest<ArtistLocal> = ArtistLocal.fetchRequest()
        
        request.predicate = NSPredicate(format: "%K == %@", argumentArray: ["mbid", artist.mbid as String])
        
        guard let artistsLocalArray = try? DB.shared.viewContext.fetch(request) else { return }
        
        for artistLocal in artistsLocalArray {
            DB.shared.viewContext.delete(artistLocal)
        }
        DB.shared.saveContext()
    }
}
