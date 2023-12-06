//
//  SplashViewModel.swift
//  exercise
//
//  Created by Jean paul on 2023-12-06.
//

import Domain
import SwiftUI

@MainActor
final class SplashViewModel: ObservableObject {
    private let TAG = "SplashViewModel"
    private let moviesRepo: MoviesRepository
    @Published private(set) var isLoading: Bool = true

    init(_ moviesRepo: MoviesRepository) {
        self.moviesRepo = moviesRepo
    }

    func fetchData() async {
        do {
            let _ = try await moviesRepo.getMovies(title: "batman", page: 1)  // load 9 movies into cache
            let _ = try await moviesRepo.getMovies(title: "batman", page: 2)
            self.isLoading = false
        } catch {
            print("\(TAG).fetchData() error: ", error)
        }

    }
}
