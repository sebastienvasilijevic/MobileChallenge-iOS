//
//  Artist.swift
//  MobileChallenge
//
//  Created by VASILIJEVIC Sebastien on 16/04/2021.
//

import Apollo

typealias Artist = ArtistsQuery.Data.Search.Artist.Node
typealias Artists = [Artist]

extension ArtistsQuery.Data.Search.Artist.Node: Hashable {
    
    public static func == (lhs: ArtistsQuery.Data.Search.Artist.Node, rhs: ArtistsQuery.Data.Search.Artist.Node) -> Bool {
        return lhs.mbid == rhs.mbid
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(mbid)
    }
}
