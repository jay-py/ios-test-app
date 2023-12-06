//
//  File.swift
//  
//
//  Created by Jean paul on 2023-12-06.
//

import Foundation

public actor MovieDetailsRepository {

    private let cache = Cache<String, MovieDetails>()
    private let mockData: Bool
    
    init(mockData: Bool = false) {
        self.mockData = mockData
    }

    public func getMovieDetails(id: String) async throws -> MovieDetails {
        let path = APIEndpoints.details(id)
        let key = path.value
        if let cached = cache[key] {
            return cached
        }
        let result = try await NetworkAgent.fetchData(
            path: path,
            responseType: MovieDetails.self,
            mockData: self.mockData)
        cache[key] = result
        try? cache.saveToDisk(withName: key)
        return result
    }
}


