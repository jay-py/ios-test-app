//
//  MovieDetails.swift
//
//
//  Created by Jean paul on 2023-12-06.
//
// swift-format-ignore-file

import SwiftUI

public struct Movie: BaseModel {

    public let id = UUID()
    public let title: String
    public let released: String
    public let poster: String
    public let plot: String
    public let genre: String
    public var imageData: Data? = nil

    public init(title: String, released: String, poster: String, plot: String, genre: String) {
        self.title = title
        self.released = released
        self.poster = poster
        self.plot = plot
        self.genre = genre
    }

    public var displayTitle: String {
        return "\(self.title)\n(\(self.released))"
    }

    public var imageURL: URL? {
        return URL(string: self.poster)
    }

    public var image: UIImage {
        if let imageData,
           let image = UIImage(data: imageData) {
            return image
        }
        return UIImage()
    }

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case poster = "Poster"
        case released = "Released"
        case plot = "Plot"
        case genre = "Genre"
    }
}

#if DEBUG
extension Movie {
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
