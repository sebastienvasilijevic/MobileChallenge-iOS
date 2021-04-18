//
//  ArtistsData.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 18/04/2021.
//

import CoreData

class ArtistsData {
    static let shared = ArtistsData()
    
    public func isBookmarked(artist: Artist) -> Bool {
        let request: NSFetchRequest<ArtistLocal> = ArtistLocal.fetchRequest()
        
        request.predicate = NSPredicate(format: "%K == %@", argumentArray: ["mbid", artist.mbid as String])
        
        guard let artistsLocalArray = try? DB.shared.viewContext.fetch(request) else { return false }
        
        return !artistsLocalArray.isEmpty
    }
    
    public func bookmarkAction(artist: Artist) {
        if isBookmarked(artist: artist) {
            self.unbookmarkArtist(artist: artist)
            
        } else {
            self.bookmarkArtist(artist: artist)
        }
    }
    
    private func bookmarkArtist(artist: Artist) {
        let artistLocal = ArtistLocal(context: DB.shared.viewContext)
        artistLocal.configure(with: artist)
        DB.shared.saveContext()
    }
    
    private func unbookmarkArtist(artist: Artist) {
        let request: NSFetchRequest<ArtistLocal> = ArtistLocal.fetchRequest()
        
        request.predicate = NSPredicate(format: "%K == %@", argumentArray: ["mbid", artist.mbid as String])
        
        guard let artistsLocalArray = try? DB.shared.viewContext.fetch(request) else { return }
        
        for artistLocal in artistsLocalArray {
            DB.shared.viewContext.delete(artistLocal)
        }
        DB.shared.saveContext()
    }
}
