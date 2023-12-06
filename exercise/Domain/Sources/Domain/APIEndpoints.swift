//
//  APIEndpoints.swift
//
//
//  Created by Jean paul on 2023-12-06.
//

import Foundation

enum APIEndpoints {
    case search(String, Int)
    case details(String)

    var value: String {
        switch self {
            case .search(let title, let page):
                return "https://www.omdbapi.com/?apikey=2ff91575&s=\(title)&type=movie&page=\(page)"
            case .details(let movieID):
                return "https://www.omdbapi.com/?apikey=2ff91575&i=\(movieID)&plot=short"
        }
    }
}
