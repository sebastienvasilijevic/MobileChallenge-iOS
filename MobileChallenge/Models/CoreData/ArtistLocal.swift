//
//  ArtistLocal.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 18/04/2021.
//

import CoreData

public class ArtistLocal: NSManagedObject {
    
    var mediaImagesArray: [Artist.ArtistMediaWikiImage] {
        get {
            guard let data = mediaWikiImages else { return [] }
            guard let result = try? JSONDecoder().decode([Artist.ArtistMediaWikiImage].self, from: data) else { return [] }
            return result
        }
        set {
            mediaWikiImages = try? JSONEncoder().encode(newValue)
        }
    }
    
    public func configure(with artist: Artist) {
        mbid = artist.mbid
        id = artist.id
        name = artist.name
        disambiguation = artist.disambiguation
        country = artist.country
        type = artist.type
        gender = artist.gender
        mediaImagesArray = artist.mediaWikiImages
    }
}
