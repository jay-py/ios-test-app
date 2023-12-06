//
//  Environment.swift
//  exercise
//
//  Created by Jean paul on 2023-12-06.
//

import Domain
import SwiftUI

private struct MoviesRepositoryKey: EnvironmentKey {
    static var defaultValue: MoviesRepository = MoviesRepository(mockData: true)
}

private struct MovieDetailsRepositoryKey: EnvironmentKey {
    static var defaultValue: MovieDetailsRepository = MovieDetailsRepository()
}

extension EnvironmentValues {
    var moviesRepository: MoviesRepository {
        get { self[MoviesRepositoryKey.self] }
        set { self[MoviesRepositoryKey.self] = newValue }
    }
    var movieDetailsRepository: MovieDetailsRepository {
        get { self[MovieDetailsRepositoryKey.self] }
        set { self[MovieDetailsRepositoryKey.self] = newValue }
    }
}
