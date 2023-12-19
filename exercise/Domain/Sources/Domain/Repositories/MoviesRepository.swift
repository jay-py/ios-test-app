//
//  MoviesRepository.swift
//
//
//  Created by Jean paul on 2023-12-06.
//

import Foundation

public actor MoviesRepository {

    public init() {}

    public func getMovies(title: String = "batman", page: Int = 1) async throws -> [Movie] {
        if let stored = await DataController.shared.getMovies(),
            !stored.isEmpty
        {
            return stored
        }
        let collection = try await NetworkAgent.fetchData(
            path: .search(title, page),
            responseType: MovieCollection.self
        )
        print(">> Collected items: ", collection.moviesIDs.count)
        var res = [Movie]()
        for item in collection.moviesIDs {
            do {
                let movie = try await getMovie(id: item.imdbID)
                res.append(movie)
            } catch {
                continue
            }
        }
        print(">> Fetched items: ", res.count)
        await DataController.shared.cacheMovies(res)
        return res
    }

    private func getMovie(id: String) async throws -> Movie {
        return try await NetworkAgent.fetchData(
            path: .details(id),
            responseType: Movie.self
        )
    }

}
