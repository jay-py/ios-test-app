//
//  MoviesRepository.swift
//
//
//  Created by Jean paul on 2023-12-06.
//

import Foundation

public actor MoviesRepository {

    public init() {}
    //URLCache.shared.memoryCapacity = 10_000_000 // ~10 MB memory space
    //URLCache.shared.diskCapacity = 1_000_000_000 // ~1GB disk cache space

    public func getMovies(title: String, page: Int = 1) async throws -> [Movie] {
        let collection = try await NetworkAgent.fetchData(
            path: .search(title, page),
            responseType: MovieCollection.self
        )
        var res = [Movie]()
        for item in collection.moviesIDs {
            do {
                let movie = try await getMovie(id: item.imdbID)
                res.append(movie)
            } catch {
                continue
            }
        }
        return res
    }

    private func getMovie(id: String) async throws -> Movie {
        return try await NetworkAgent.fetchData(
            path: .details(id),
            responseType: Movie.self
        )
    }

}
