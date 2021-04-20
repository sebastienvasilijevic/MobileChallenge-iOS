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
    var gender: String!
    var tags: ArtistTags!
    var rating: ArtistRating!
    var mediaWikiImages: [ArtistMediaWikiImage] = []
    
    var isBookmarked: Bool = false
    
    public struct ArtistTags: Codable {
        var nodes: [Node] = []
        
        public struct Node: Codable {
            var name: String!
            var count: Int!
        }
        
        /// Only get tags which count is more than 1 (Not to get too many tags) and sort descending
        public func filterAndSort() -> [Node] {
            return nodes.filter({ $0.count > 1 }).sorted(by: { $0.count > $1.count })
        }
    }
    
    public struct ArtistRating: Codable {
        var value: Double!
        var voteCount: Int!
    }
    
    public struct ArtistMediaWikiImage: Codable {
        var url: String!
    }
    
    
    // MARK: - Init methods
    
    init(apiArtistNode artist: ArtistsQuery.Data.Search.Artist.Node) {
        self.mbid = artist.mbid
        self.id = artist.id
        self.name = artist.name
        self.disambiguation = artist.disambiguation
        self.country = artist.country
        self.type = artist.type
        self.gender = artist.gender
        
        var mediaImagesArray: [ArtistMediaWikiImage] = []
        for mMediaWikiImage in artist.mediaWikiImages {
            mediaImagesArray.append(.init(url: mMediaWikiImage?.url))
        }
        self.mediaWikiImages = mediaImagesArray
    }
    
    init(apiArtistDetailsNode artist: ArtistDetailsQuery.Data.Node.AsArtist) {
        self.mbid = artist.mbid
        self.id = artist.id
        self.name = artist.name
        self.disambiguation = artist.disambiguation
        self.country = artist.country
        self.type = artist.type
        self.gender = artist.gender

        var tagNodesArray: [ArtistTags.Node] = []
        if let mArtistTags = artist.tags {
            for mTag in (mArtistTags.nodes ?? []) {
                tagNodesArray.append(.init(name: mTag?.name, count: mTag?.count))
            }
        }
        self.tags = .init(nodes: tagNodesArray)
        
        if let mArtistRating = artist.rating {
            self.rating = .init(value: mArtistRating.value, voteCount: mArtistRating.voteCount)
        }

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
        self.gender = artist.gender
        self.mediaWikiImages = artist.mediaImagesArray
    }
    
    // MARK: -
    
    /// Get WikiImage object where url is not empty
    public func getMediaImages() -> [ArtistMediaWikiImage] {
        return self.mediaWikiImages.compactMap{ $0 }.filter{ !$0.url.isEmpty }
    }
    
    /// Get first image uri
    public func getFirstImageUri() -> String {
        return self.getMediaImages().first?.url ?? ""
    }
    
    /// Convert flag country String into emoji flag
    public func getCountryFlag() -> String {
        let base: UInt32 = 127397
        var s = ""
        for v in (self.country ?? "").unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(self.country == "XW" ? "" : s)
    }
    
    public func getReadableGender() -> String {
        return gender == "not applicable" ? "" : (gender ?? "")
    }
    
    public func getTypeAndGender() -> String {
        var s: String = ""
        
        if type != nil && !type.isEmpty {
            s += type
        }
        
        if !getReadableGender().isEmpty {
            s += s.isEmpty ? "" : " "
            s += "(\(getReadableGender()))"
        }
        
        return s
    }
    
    public func commentsIsEmpty() -> Bool {
        return disambiguation == nil || disambiguation.isEmpty
    }
    
    public func tagsIsEmpty() -> Bool {
        return tags == nil || tags.filterAndSort().isEmpty
    }
    
    public func ratingIsEmpty() -> Bool {
        return rating == nil || rating.value == nil || rating.voteCount == 0
    }
    
    public func getRatingStarsText() -> String {
        return ratingIsEmpty() ? "" : "\(rating.value!) (\(rating.voteCount!))"
    }
    
    
    // MARK: - Hashable methods
    
    public static func == (lhs: Artist, rhs: Artist) -> Bool {
        return lhs.mbid == rhs.mbid
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(mbid)
    }
}
