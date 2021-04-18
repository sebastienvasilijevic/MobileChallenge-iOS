// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class ArtistsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Artists($search: String!, $first: Int!, $after: String) {
      search {
        __typename
        artists(query: $search, first: $first, after: $after) {
          __typename
          nodes {
            __typename
            ...ArtistBasicFragment
          }
          pageInfo {
            __typename
            hasNextPage
            endCursor
          }
        }
      }
    }
    """

  public let operationName: String = "Artists"

  public var queryDocument: String { return operationDefinition.appending("\n" + ArtistBasicFragment.fragmentDefinition) }

  public var search: String
  public var first: Int
  public var after: String?

  public init(search: String, first: Int, after: String? = nil) {
    self.search = search
    self.first = first
    self.after = after
  }

  public var variables: GraphQLMap? {
    return ["search": search, "first": first, "after": after]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("search", type: .object(Search.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(search: Search? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "search": search.flatMap { (value: Search) -> ResultMap in value.resultMap }])
    }

    /// Search for MusicBrainz entities using Lucene query syntax.
    public var search: Search? {
      get {
        return (resultMap["search"] as? ResultMap).flatMap { Search(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "search")
      }
    }

    public struct Search: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["SearchQuery"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("artists", arguments: ["query": GraphQLVariable("search"), "first": GraphQLVariable("first"), "after": GraphQLVariable("after")], type: .object(Artist.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(artists: Artist? = nil) {
        self.init(unsafeResultMap: ["__typename": "SearchQuery", "artists": artists.flatMap { (value: Artist) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// Search for artist entities matching the given query.
      public var artists: Artist? {
        get {
          return (resultMap["artists"] as? ResultMap).flatMap { Artist(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "artists")
        }
      }

      public struct Artist: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["ArtistConnection"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("nodes", type: .list(.object(Node.selections))),
            GraphQLField("pageInfo", type: .nonNull(.object(PageInfo.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(nodes: [Node?]? = nil, pageInfo: PageInfo) {
          self.init(unsafeResultMap: ["__typename": "ArtistConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, "pageInfo": pageInfo.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of nodes in the connection (without going through the
        /// `edges` field).
        public var nodes: [Node?]? {
          get {
            return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
          }
        }

        /// Information to aid in pagination.
        public var pageInfo: PageInfo {
          get {
            return PageInfo(unsafeResultMap: resultMap["pageInfo"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "pageInfo")
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Artist"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("mbid", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
              GraphQLField("name", type: .scalar(String.self)),
              GraphQLField("disambiguation", type: .scalar(String.self)),
              GraphQLField("type", type: .scalar(String.self)),
              GraphQLField("gender", type: .scalar(String.self)),
              GraphQLField("country", type: .scalar(String.self)),
              GraphQLField("mediaWikiImages", type: .nonNull(.list(.object(MediaWikiImage.selections)))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(mbid: String, id: GraphQLID, name: String? = nil, disambiguation: String? = nil, type: String? = nil, gender: String? = nil, country: String? = nil, mediaWikiImages: [MediaWikiImage?]) {
            self.init(unsafeResultMap: ["__typename": "Artist", "mbid": mbid, "id": id, "name": name, "disambiguation": disambiguation, "type": type, "gender": gender, "country": country, "mediaWikiImages": mediaWikiImages.map { (value: MediaWikiImage?) -> ResultMap? in value.flatMap { (value: MediaWikiImage) -> ResultMap in value.resultMap } }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The MBID of the entity.
          public var mbid: String {
            get {
              return resultMap["mbid"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "mbid")
            }
          }

          /// The ID of an object
          public var id: GraphQLID {
            get {
              return resultMap["id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          /// The official name of the entity.
          public var name: String? {
            get {
              return resultMap["name"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }

          /// A comment used to help distinguish identically named entitites.
          public var disambiguation: String? {
            get {
              return resultMap["disambiguation"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "disambiguation")
            }
          }

          /// Whether an artist is a person, a group, or something else.
          public var type: String? {
            get {
              return resultMap["type"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "type")
            }
          }

          /// Whether a person or character identifies as male, female, or
          /// neither. Groups do not have genders.
          public var gender: String? {
            get {
              return resultMap["gender"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "gender")
            }
          }

          /// The country with which an artist is primarily identified. It
          /// is often, but not always, its birth/formation country.
          public var country: String? {
            get {
              return resultMap["country"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "country")
            }
          }

          /// Artist images found at MediaWiki URLs in the artist’s URL relationships.
          /// Defaults to URL relationships with the type “image”.
          /// This field is provided by the MediaWiki extension.
          public var mediaWikiImages: [MediaWikiImage?] {
            get {
              return (resultMap["mediaWikiImages"] as! [ResultMap?]).map { (value: ResultMap?) -> MediaWikiImage? in value.flatMap { (value: ResultMap) -> MediaWikiImage in MediaWikiImage(unsafeResultMap: value) } }
            }
            set {
              resultMap.updateValue(newValue.map { (value: MediaWikiImage?) -> ResultMap? in value.flatMap { (value: MediaWikiImage) -> ResultMap in value.resultMap } }, forKey: "mediaWikiImages")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var artistBasicFragment: ArtistBasicFragment {
              get {
                return ArtistBasicFragment(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }

          public struct MediaWikiImage: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["MediaWikiImage"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("url", type: .nonNull(.scalar(String.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(url: String) {
              self.init(unsafeResultMap: ["__typename": "MediaWikiImage", "url": url])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The URL of the actual image file.
            public var url: String {
              get {
                return resultMap["url"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "url")
              }
            }
          }
        }

        public struct PageInfo: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["PageInfo"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("hasNextPage", type: .nonNull(.scalar(Bool.self))),
              GraphQLField("endCursor", type: .scalar(String.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(hasNextPage: Bool, endCursor: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "PageInfo", "hasNextPage": hasNextPage, "endCursor": endCursor])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// When paginating forwards, are there more items?
          public var hasNextPage: Bool {
            get {
              return resultMap["hasNextPage"]! as! Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "hasNextPage")
            }
          }

          /// When paginating forwards, the cursor to continue.
          public var endCursor: String? {
            get {
              return resultMap["endCursor"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "endCursor")
            }
          }
        }
      }
    }
  }
}

public final class ArtistDetailsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query ArtistDetails($id: ID!) {
      node(id: $id) {
        __typename
        ...ArtistDetailsFragment
      }
    }
    """

  public let operationName: String = "ArtistDetails"

  public var queryDocument: String { return operationDefinition.appending("\n" + ArtistDetailsFragment.fragmentDefinition) }

  public var id: GraphQLID

  public init(id: GraphQLID) {
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("node", arguments: ["id": GraphQLVariable("id")], type: .object(Node.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(node: Node? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "node": node.flatMap { (value: Node) -> ResultMap in value.resultMap }])
    }

    /// Fetches an object given its ID
    public var node: Node? {
      get {
        return (resultMap["node"] as? ResultMap).flatMap { Node(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "node")
      }
    }

    public struct Node: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Area", "Artist", "Recording", "Release", "Disc", "Label", "Collection", "Event", "Instrument", "Place", "ReleaseGroup", "Series", "Work", "URL"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLTypeCase(
            variants: ["Artist": AsArtist.selections],
            default: [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            ]
          )
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public static func makeArea() -> Node {
        return Node(unsafeResultMap: ["__typename": "Area"])
      }

      public static func makeRecording() -> Node {
        return Node(unsafeResultMap: ["__typename": "Recording"])
      }

      public static func makeRelease() -> Node {
        return Node(unsafeResultMap: ["__typename": "Release"])
      }

      public static func makeDisc() -> Node {
        return Node(unsafeResultMap: ["__typename": "Disc"])
      }

      public static func makeLabel() -> Node {
        return Node(unsafeResultMap: ["__typename": "Label"])
      }

      public static func makeCollection() -> Node {
        return Node(unsafeResultMap: ["__typename": "Collection"])
      }

      public static func makeEvent() -> Node {
        return Node(unsafeResultMap: ["__typename": "Event"])
      }

      public static func makeInstrument() -> Node {
        return Node(unsafeResultMap: ["__typename": "Instrument"])
      }

      public static func makePlace() -> Node {
        return Node(unsafeResultMap: ["__typename": "Place"])
      }

      public static func makeReleaseGroup() -> Node {
        return Node(unsafeResultMap: ["__typename": "ReleaseGroup"])
      }

      public static func makeSeries() -> Node {
        return Node(unsafeResultMap: ["__typename": "Series"])
      }

      public static func makeWork() -> Node {
        return Node(unsafeResultMap: ["__typename": "Work"])
      }

      public static func makeURL() -> Node {
        return Node(unsafeResultMap: ["__typename": "URL"])
      }

      public static func makeArtist(mbid: String, id: GraphQLID, name: String? = nil, disambiguation: String? = nil, type: String? = nil, gender: String? = nil, country: String? = nil, tags: AsArtist.Tag? = nil, rating: AsArtist.Rating? = nil, mediaWikiImages: [AsArtist.MediaWikiImage?]) -> Node {
        return Node(unsafeResultMap: ["__typename": "Artist", "mbid": mbid, "id": id, "name": name, "disambiguation": disambiguation, "type": type, "gender": gender, "country": country, "tags": tags.flatMap { (value: AsArtist.Tag) -> ResultMap in value.resultMap }, "rating": rating.flatMap { (value: AsArtist.Rating) -> ResultMap in value.resultMap }, "mediaWikiImages": mediaWikiImages.map { (value: AsArtist.MediaWikiImage?) -> ResultMap? in value.flatMap { (value: AsArtist.MediaWikiImage) -> ResultMap in value.resultMap } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var artistDetailsFragment: ArtistDetailsFragment? {
          get {
            if !ArtistDetailsFragment.possibleTypes.contains(resultMap["__typename"]! as! String) { return nil }
            return ArtistDetailsFragment(unsafeResultMap: resultMap)
          }
          set {
            guard let newValue = newValue else { return }
            resultMap += newValue.resultMap
          }
        }
      }

      public var asArtist: AsArtist? {
        get {
          if !AsArtist.possibleTypes.contains(__typename) { return nil }
          return AsArtist(unsafeResultMap: resultMap)
        }
        set {
          guard let newValue = newValue else { return }
          resultMap = newValue.resultMap
        }
      }

      public struct AsArtist: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Artist"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("mbid", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("name", type: .scalar(String.self)),
            GraphQLField("disambiguation", type: .scalar(String.self)),
            GraphQLField("type", type: .scalar(String.self)),
            GraphQLField("gender", type: .scalar(String.self)),
            GraphQLField("country", type: .scalar(String.self)),
            GraphQLField("tags", type: .object(Tag.selections)),
            GraphQLField("rating", type: .object(Rating.selections)),
            GraphQLField("mediaWikiImages", type: .nonNull(.list(.object(MediaWikiImage.selections)))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(mbid: String, id: GraphQLID, name: String? = nil, disambiguation: String? = nil, type: String? = nil, gender: String? = nil, country: String? = nil, tags: Tag? = nil, rating: Rating? = nil, mediaWikiImages: [MediaWikiImage?]) {
          self.init(unsafeResultMap: ["__typename": "Artist", "mbid": mbid, "id": id, "name": name, "disambiguation": disambiguation, "type": type, "gender": gender, "country": country, "tags": tags.flatMap { (value: Tag) -> ResultMap in value.resultMap }, "rating": rating.flatMap { (value: Rating) -> ResultMap in value.resultMap }, "mediaWikiImages": mediaWikiImages.map { (value: MediaWikiImage?) -> ResultMap? in value.flatMap { (value: MediaWikiImage) -> ResultMap in value.resultMap } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The MBID of the entity.
        public var mbid: String {
          get {
            return resultMap["mbid"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "mbid")
          }
        }

        /// The ID of an object
        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        /// The official name of the entity.
        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        /// A comment used to help distinguish identically named entitites.
        public var disambiguation: String? {
          get {
            return resultMap["disambiguation"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "disambiguation")
          }
        }

        /// Whether an artist is a person, a group, or something else.
        public var type: String? {
          get {
            return resultMap["type"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "type")
          }
        }

        /// Whether a person or character identifies as male, female, or
        /// neither. Groups do not have genders.
        public var gender: String? {
          get {
            return resultMap["gender"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "gender")
          }
        }

        /// The country with which an artist is primarily identified. It
        /// is often, but not always, its birth/formation country.
        public var country: String? {
          get {
            return resultMap["country"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "country")
          }
        }

        /// A list of tags linked to this entity.
        public var tags: Tag? {
          get {
            return (resultMap["tags"] as? ResultMap).flatMap { Tag(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "tags")
          }
        }

        /// The rating users have given to this entity.
        public var rating: Rating? {
          get {
            return (resultMap["rating"] as? ResultMap).flatMap { Rating(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "rating")
          }
        }

        /// Artist images found at MediaWiki URLs in the artist’s URL relationships.
        /// Defaults to URL relationships with the type “image”.
        /// This field is provided by the MediaWiki extension.
        public var mediaWikiImages: [MediaWikiImage?] {
          get {
            return (resultMap["mediaWikiImages"] as! [ResultMap?]).map { (value: ResultMap?) -> MediaWikiImage? in value.flatMap { (value: ResultMap) -> MediaWikiImage in MediaWikiImage(unsafeResultMap: value) } }
          }
          set {
            resultMap.updateValue(newValue.map { (value: MediaWikiImage?) -> ResultMap? in value.flatMap { (value: MediaWikiImage) -> ResultMap in value.resultMap } }, forKey: "mediaWikiImages")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var artistDetailsFragment: ArtistDetailsFragment {
            get {
              return ArtistDetailsFragment(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }

        public struct Tag: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["TagConnection"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("nodes", type: .list(.object(Node.selections))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(nodes: [Node?]? = nil) {
            self.init(unsafeResultMap: ["__typename": "TagConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// A list of nodes in the connection (without going through the
          /// `edges` field).
          public var nodes: [Node?]? {
            get {
              return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
            }
          }

          public struct Node: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["Tag"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("name", type: .nonNull(.scalar(String.self))),
                GraphQLField("count", type: .scalar(Int.self)),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(name: String, count: Int? = nil) {
              self.init(unsafeResultMap: ["__typename": "Tag", "name": name, "count": count])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The tag label.
            public var name: String {
              get {
                return resultMap["name"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "name")
              }
            }

            /// How many times this tag has been applied to the entity.
            public var count: Int? {
              get {
                return resultMap["count"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "count")
              }
            }
          }
        }

        public struct Rating: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Rating"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("value", type: .scalar(Double.self)),
              GraphQLField("voteCount", type: .nonNull(.scalar(Int.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(value: Double? = nil, voteCount: Int) {
            self.init(unsafeResultMap: ["__typename": "Rating", "value": value, "voteCount": voteCount])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The average rating value based on the aggregated votes.
          public var value: Double? {
            get {
              return resultMap["value"] as? Double
            }
            set {
              resultMap.updateValue(newValue, forKey: "value")
            }
          }

          /// The number of votes that have contributed to the rating.
          public var voteCount: Int {
            get {
              return resultMap["voteCount"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "voteCount")
            }
          }
        }

        public struct MediaWikiImage: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["MediaWikiImage"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("url", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(url: String) {
            self.init(unsafeResultMap: ["__typename": "MediaWikiImage", "url": url])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The URL of the actual image file.
          public var url: String {
            get {
              return resultMap["url"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "url")
            }
          }
        }
      }
    }
  }
}

public struct ArtistBasicFragment: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment ArtistBasicFragment on Artist {
      __typename
      mbid
      id
      name
      disambiguation
      type
      gender
      country
      mediaWikiImages {
        __typename
        url
      }
    }
    """

  public static let possibleTypes: [String] = ["Artist"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("mbid", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("name", type: .scalar(String.self)),
      GraphQLField("disambiguation", type: .scalar(String.self)),
      GraphQLField("type", type: .scalar(String.self)),
      GraphQLField("gender", type: .scalar(String.self)),
      GraphQLField("country", type: .scalar(String.self)),
      GraphQLField("mediaWikiImages", type: .nonNull(.list(.object(MediaWikiImage.selections)))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(mbid: String, id: GraphQLID, name: String? = nil, disambiguation: String? = nil, type: String? = nil, gender: String? = nil, country: String? = nil, mediaWikiImages: [MediaWikiImage?]) {
    self.init(unsafeResultMap: ["__typename": "Artist", "mbid": mbid, "id": id, "name": name, "disambiguation": disambiguation, "type": type, "gender": gender, "country": country, "mediaWikiImages": mediaWikiImages.map { (value: MediaWikiImage?) -> ResultMap? in value.flatMap { (value: MediaWikiImage) -> ResultMap in value.resultMap } }])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  /// The MBID of the entity.
  public var mbid: String {
    get {
      return resultMap["mbid"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "mbid")
    }
  }

  /// The ID of an object
  public var id: GraphQLID {
    get {
      return resultMap["id"]! as! GraphQLID
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }

  /// The official name of the entity.
  public var name: String? {
    get {
      return resultMap["name"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "name")
    }
  }

  /// A comment used to help distinguish identically named entitites.
  public var disambiguation: String? {
    get {
      return resultMap["disambiguation"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "disambiguation")
    }
  }

  /// Whether an artist is a person, a group, or something else.
  public var type: String? {
    get {
      return resultMap["type"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "type")
    }
  }

  /// Whether a person or character identifies as male, female, or
  /// neither. Groups do not have genders.
  public var gender: String? {
    get {
      return resultMap["gender"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "gender")
    }
  }

  /// The country with which an artist is primarily identified. It
  /// is often, but not always, its birth/formation country.
  public var country: String? {
    get {
      return resultMap["country"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "country")
    }
  }

  /// Artist images found at MediaWiki URLs in the artist’s URL relationships.
  /// Defaults to URL relationships with the type “image”.
  /// This field is provided by the MediaWiki extension.
  public var mediaWikiImages: [MediaWikiImage?] {
    get {
      return (resultMap["mediaWikiImages"] as! [ResultMap?]).map { (value: ResultMap?) -> MediaWikiImage? in value.flatMap { (value: ResultMap) -> MediaWikiImage in MediaWikiImage(unsafeResultMap: value) } }
    }
    set {
      resultMap.updateValue(newValue.map { (value: MediaWikiImage?) -> ResultMap? in value.flatMap { (value: MediaWikiImage) -> ResultMap in value.resultMap } }, forKey: "mediaWikiImages")
    }
  }

  public struct MediaWikiImage: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["MediaWikiImage"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("url", type: .nonNull(.scalar(String.self))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(url: String) {
      self.init(unsafeResultMap: ["__typename": "MediaWikiImage", "url": url])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// The URL of the actual image file.
    public var url: String {
      get {
        return resultMap["url"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "url")
      }
    }
  }
}

public struct ArtistDetailsFragment: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment ArtistDetailsFragment on Artist {
      __typename
      mbid
      id
      name
      disambiguation
      type
      gender
      country
      tags {
        __typename
        nodes {
          __typename
          name
          count
        }
      }
      rating {
        __typename
        value
        voteCount
      }
      mediaWikiImages {
        __typename
        url
      }
    }
    """

  public static let possibleTypes: [String] = ["Artist"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("mbid", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("name", type: .scalar(String.self)),
      GraphQLField("disambiguation", type: .scalar(String.self)),
      GraphQLField("type", type: .scalar(String.self)),
      GraphQLField("gender", type: .scalar(String.self)),
      GraphQLField("country", type: .scalar(String.self)),
      GraphQLField("tags", type: .object(Tag.selections)),
      GraphQLField("rating", type: .object(Rating.selections)),
      GraphQLField("mediaWikiImages", type: .nonNull(.list(.object(MediaWikiImage.selections)))),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(mbid: String, id: GraphQLID, name: String? = nil, disambiguation: String? = nil, type: String? = nil, gender: String? = nil, country: String? = nil, tags: Tag? = nil, rating: Rating? = nil, mediaWikiImages: [MediaWikiImage?]) {
    self.init(unsafeResultMap: ["__typename": "Artist", "mbid": mbid, "id": id, "name": name, "disambiguation": disambiguation, "type": type, "gender": gender, "country": country, "tags": tags.flatMap { (value: Tag) -> ResultMap in value.resultMap }, "rating": rating.flatMap { (value: Rating) -> ResultMap in value.resultMap }, "mediaWikiImages": mediaWikiImages.map { (value: MediaWikiImage?) -> ResultMap? in value.flatMap { (value: MediaWikiImage) -> ResultMap in value.resultMap } }])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  /// The MBID of the entity.
  public var mbid: String {
    get {
      return resultMap["mbid"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "mbid")
    }
  }

  /// The ID of an object
  public var id: GraphQLID {
    get {
      return resultMap["id"]! as! GraphQLID
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }

  /// The official name of the entity.
  public var name: String? {
    get {
      return resultMap["name"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "name")
    }
  }

  /// A comment used to help distinguish identically named entitites.
  public var disambiguation: String? {
    get {
      return resultMap["disambiguation"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "disambiguation")
    }
  }

  /// Whether an artist is a person, a group, or something else.
  public var type: String? {
    get {
      return resultMap["type"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "type")
    }
  }

  /// Whether a person or character identifies as male, female, or
  /// neither. Groups do not have genders.
  public var gender: String? {
    get {
      return resultMap["gender"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "gender")
    }
  }

  /// The country with which an artist is primarily identified. It
  /// is often, but not always, its birth/formation country.
  public var country: String? {
    get {
      return resultMap["country"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "country")
    }
  }

  /// A list of tags linked to this entity.
  public var tags: Tag? {
    get {
      return (resultMap["tags"] as? ResultMap).flatMap { Tag(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "tags")
    }
  }

  /// The rating users have given to this entity.
  public var rating: Rating? {
    get {
      return (resultMap["rating"] as? ResultMap).flatMap { Rating(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "rating")
    }
  }

  /// Artist images found at MediaWiki URLs in the artist’s URL relationships.
  /// Defaults to URL relationships with the type “image”.
  /// This field is provided by the MediaWiki extension.
  public var mediaWikiImages: [MediaWikiImage?] {
    get {
      return (resultMap["mediaWikiImages"] as! [ResultMap?]).map { (value: ResultMap?) -> MediaWikiImage? in value.flatMap { (value: ResultMap) -> MediaWikiImage in MediaWikiImage(unsafeResultMap: value) } }
    }
    set {
      resultMap.updateValue(newValue.map { (value: MediaWikiImage?) -> ResultMap? in value.flatMap { (value: MediaWikiImage) -> ResultMap in value.resultMap } }, forKey: "mediaWikiImages")
    }
  }

  public struct Tag: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["TagConnection"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("nodes", type: .list(.object(Node.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(nodes: [Node?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "TagConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// A list of nodes in the connection (without going through the
    /// `edges` field).
    public var nodes: [Node?]? {
      get {
        return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
      }
    }

    public struct Node: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Tag"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("count", type: .scalar(Int.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(name: String, count: Int? = nil) {
        self.init(unsafeResultMap: ["__typename": "Tag", "name": name, "count": count])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The tag label.
      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      /// How many times this tag has been applied to the entity.
      public var count: Int? {
        get {
          return resultMap["count"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "count")
        }
      }
    }
  }

  public struct Rating: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Rating"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("value", type: .scalar(Double.self)),
        GraphQLField("voteCount", type: .nonNull(.scalar(Int.self))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(value: Double? = nil, voteCount: Int) {
      self.init(unsafeResultMap: ["__typename": "Rating", "value": value, "voteCount": voteCount])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// The average rating value based on the aggregated votes.
    public var value: Double? {
      get {
        return resultMap["value"] as? Double
      }
      set {
        resultMap.updateValue(newValue, forKey: "value")
      }
    }

    /// The number of votes that have contributed to the rating.
    public var voteCount: Int {
      get {
        return resultMap["voteCount"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "voteCount")
      }
    }
  }

  public struct MediaWikiImage: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["MediaWikiImage"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("url", type: .nonNull(.scalar(String.self))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(url: String) {
      self.init(unsafeResultMap: ["__typename": "MediaWikiImage", "url": url])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// The URL of the actual image file.
    public var url: String {
      get {
        return resultMap["url"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "url")
      }
    }
  }
}
