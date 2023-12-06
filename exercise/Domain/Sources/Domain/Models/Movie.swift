//
//  Movie.swift
//
//
//  Created by Jean paul on 2023-12-06.
//
// swift-format-ignore-file

import Foundation

public struct Movie: BaseModel {
    
    
    public let id = UUID()
    public let items: [MovieItem]
    enum CodingKeys: String, CodingKey {
        case items = "Search"
    }
    
    public struct MovieItem: Codable {
        let title: String
        let imdbID: String
        let poster: String
        
        var imageURL: URL? {
            return URL(string: self.poster)
        }
        
        enum CodingKeys: String, CodingKey {
            case title = "Title"
            case imdbID = "imdbID"
            case poster = "Poster"
        }
        
    }
    
    public static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }
}

#if DEBUG
extension Movie {
    static var mockData: Data! = """
    {
      "Search": [
        {
          "Title": "Batman Begins",
          "imdbID": "tt0372784",
          "Poster": "https://m.media-amazon.com/images/M/MV5BOTY4YjI2N2MtYmFlMC00ZjcyLTg3YjEtMDQyM2ZjYzQ5YWFkXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg"
        },
        {
          "Title": "The Batman",
          "imdbID": "tt1877830",
          "Poster": "https://m.media-amazon.com/images/M/MV5BM2MyNTAwZGEtNTAxNC00ODVjLTgzZjUtYmU0YjAzNmQyZDEwXkEyXkFqcGdeQXVyNDc2NTg3NzA@._V1_SX300.jpg"
        },
        {
          "Title": "Batman v Superman: Dawn of Justice",
          "imdbID": "tt2975590",
          "Poster": "https://m.media-amazon.com/images/M/MV5BYThjYzcyYzItNTVjNy00NDk0LTgwMWQtYjMwNmNlNWJhMzMyXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg"
        },
        {
          "Title": "Batman: The Killing Joke",
          "imdbID": "tt4853102",
          "Poster": "https://m.media-amazon.com/images/M/MV5BMTdjZTliODYtNWExMi00NjQ1LWIzN2MtN2Q5NTg5NTk3NzliL2ltYWdlXkEyXkFqcGdeQXVyNTAyODkwOQ@@._V1_SX300.jpg"
        }
      ]
    }
    """.data(using: .utf8)
}
#endif
