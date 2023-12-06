//
//  MovieDetails.swift
//
//
//  Created by Jean paul on 2023-12-06.
//
// swift-format-ignore-file

import Foundation

public struct MovieDetails: BaseModel {

    public let id = UUID()
    let title: String
    let poster: String
    let released: String
    let genre: String
    let plot: String

    var imageURL: URL? {
        return URL(string: self.poster)
    }

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case poster = "Poster"
        case released = "Released"
        case genre = "Genre"
        case plot = "Plot"
    }
}

#if DEBUG
extension MovieDetails {
    static var mockData: Data! = """
    {
      "Title": "Batman v Superman: Dawn of Justice (Ultimate Edition)",
      "Released": "23 Mar 2016",
      "Genre": "Action, Adventure, Sci-Fi",
      "Plot": "Batman is manipulated by Lex Luthor to fear Superman. Superman´s existence is meanwhile dividing the world and he is framed for murder during an international crisis. The heroes clash and force the neutral Wonder Woman to reemerge.",
      "Poster": "https://m.media-amazon.com/images/M/MV5BOTRlNWQwM2ItNjkyZC00MGI3LThkYjktZmE5N2FlMzcyNTIyXkEyXkFqcGdeQXVyMTEyNzgwMDUw._V1_SX300.jpg",
    }
    """.data(using: .utf8)
}
#endif
