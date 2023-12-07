//
//  Movie.swift
//
//
//  Created by Jean paul on 2023-12-06.
//
// swift-format-ignore-file

import Foundation

public struct MovieCollection: BaseModel {

    public let id = UUID()
    public let moviesIDs: [MovieItem]

    public init(_ IDs: [MovieItem]) {
        self.moviesIDs = IDs
    }

    enum CodingKeys: String, CodingKey {
        case moviesIDs = "Search"
    }

    public struct MovieItem: BaseModel {
        static var mockData: Data! = nil
        public let id = UUID()

        public let imdbID: String

        enum CodingKeys: String, CodingKey {
            case imdbID = "imdbID"
        }
    }
}

#if DEBUG
extension MovieCollection {
    static var mockData: Data! = """
    {
      "Search": [
        {
          "imdbID": "tt0372784",
        },
        {
          "imdbID": "tt1877830",
        },
        {
          "imdbID": "tt2975590",
        },
        {
          "imdbID": "tt4853102",
        },
        {
          "imdbID": "tt4853102",
        },
        {
          "imdbID": "tt4853102",
        },
        {
          "imdbID": "tt4853102",
        },
        {
          "imdbID": "tt4853102",
        }
      ]
    }
    """.data(using: .utf8)
}
#endif
