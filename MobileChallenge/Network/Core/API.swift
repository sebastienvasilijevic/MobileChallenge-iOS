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
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(nodes: [Node?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "ArtistConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
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
          public static let possibleTypes: [String] = ["Artist"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
              GraphQLField("name", type: .scalar(String.self)),
              GraphQLField("disambiguation", type: .scalar(String.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, name: String? = nil, disambiguation: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "Artist", "id": id, "name": name, "disambiguation": disambiguation])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
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
      id
      name
      disambiguation
    }
    """

  public static let possibleTypes: [String] = ["Artist"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("name", type: .scalar(String.self)),
      GraphQLField("disambiguation", type: .scalar(String.self)),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, name: String? = nil, disambiguation: String? = nil) {
    self.init(unsafeResultMap: ["__typename": "Artist", "id": id, "name": name, "disambiguation": disambiguation])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
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
}
