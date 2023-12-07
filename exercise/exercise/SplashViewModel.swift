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
            let stored = DataController.shared.movies
            if !stored.isEmpty {
                self.isLoading = false
                return
            }
            let res = try await moviesRepo.getMovies(title: "batman")
            DataController.shared.movies = res
            self.isLoading = false
        } catch {
            print("\(TAG).fetchData() error: ", error)
        }

    }
}
