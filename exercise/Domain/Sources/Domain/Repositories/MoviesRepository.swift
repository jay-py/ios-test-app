//
//  MoviesRepository.swift
//
//
//  Created by Jean paul on 2023-12-06.
//

import Foundation

public actor MoviesRepository {

    private let cache = Cache<String, Movie>()
    private let mockData: Bool

    public init(mockData: Bool = false) {
        self.mockData = mockData
    }

    //URLCache.shared.memoryCapacity = 10_000_000 // ~10 MB memory space
    //URLCache.shared.diskCapacity = 1_000_000_000 // ~1GB disk cache space

    public func getMovies(title: String, page: Int) async throws -> Movie {
        let path = APIEndpoints.search(title, page)
        let key = path.value
        if let cached = cache[key] {
            print(">> cached")
            return cached
        }
        let result = try await NetworkAgent.fetchData(
            path: path,
            responseType: Movie.self,
            mockData: self.mockData)
        cache[key] = result
        try? cache.saveToDisk(withName: key)
        return result
    }

}
