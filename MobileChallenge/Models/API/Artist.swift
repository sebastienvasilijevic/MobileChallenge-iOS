//
//  Artist.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 16/04/2021.
//

import Apollo

/// We create Artist object to conform to Codable
public struct Artist: Codable, Hashable {
    var mbid: String!
    var id: String!
    var name: String!
    var disambiguation: String!
    var country: String!
    var type: String!
    var tags: ArtistTags!
    var mediaWikiImages: [ArtistMediaWikiImage] = []
    
    var isBookmarked: Bool = false
    
    public struct ArtistTags: Codable {
        var nodes: [Node] = []
        
        struct Node: Codable {
            var name: String!
            var count: Int!
        }
    }
    
    public struct ArtistMediaWikiImage: Codable {
        var url: String!
    }
    
    
    init(apiArtistNode artist: ArtistsQuery.Data.Search.Artist.Node) {
        self.mbid = artist.mbid
        self.id = artist.id
        self.name = artist.name
        self.disambiguation = artist.disambiguation
        self.country = artist.country
        self.type = artist.type
        
        var tagNodesArray: [ArtistTags.Node] = []
        if let mArtistTags = artist.tags {
            for mTag in (mArtistTags.nodes ?? []) {
                tagNodesArray.append(.init(name: mTag?.name, count: mTag?.count))
            }
        }
        self.tags = .init(nodes: tagNodesArray)
        
        var mediaImagesArray: [ArtistMediaWikiImage] = []
        for mMediaWikiImage in artist.mediaWikiImages {
            mediaImagesArray.append(.init(url: mMediaWikiImage?.url))
        }
        self.mediaWikiImages = mediaImagesArray
    }
    
    init(artistLocal artist: ArtistLocal) {
        self.mbid = artist.mbid
        self.id = artist.id
        self.name = artist.name
        self.disambiguation = artist.disambiguation
        self.country = artist.country
        self.type = artist.type
        self.mediaWikiImages = artist.mediaImagesArray
    }
    
    
    public func getMediaImages() -> [ArtistMediaWikiImage] {
        return self.mediaWikiImages.compactMap{ $0 }.filter{ !$0.url.isEmpty }
    }
    
    public func getCountryFlag() -> String {
        let base: UInt32 = 127397
        var s = ""
        for v in (self.country ?? "").unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(self.country == "XW" ? "" : s)
    }
    
    public func getReadableType() -> String {
        return type == "not applicable" ? "" : (type ?? "")
    }
    
    public static func == (lhs: Artist, rhs: Artist) -> Bool {
        return lhs.mbid == rhs.mbid
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(mbid)
    }
}

//extension ArtistsQuery.Data.Search.Artist.Node: Hashable {
//    
//
//    
//    public static func == (lhs: ArtistsQuery.Data.Search.Artist.Node, rhs: ArtistsQuery.Data.Search.Artist.Node) -> Bool {
//        return lhs.mbid == rhs.mbid
//    }
//    
//    public func hash(into hasher: inout Hasher) {
//        hasher.combine(mbid)
//    }
//}
