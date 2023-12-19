//
//  SplashViewModel.swift
//  exercise
//
//  Created by Jean paul on 2023-12-06.
//
import Combine
import Domain
import SwiftUI

@MainActor
final class SplashViewModel: ObservableObject {
    private let TAG = "SplashViewModel"
    private let moviesRepo: MoviesRepository
    private var bag = Set<AnyCancellable>()

    @Published private(set) var isLoading: Bool = true
    internal var state: State = .idle {
        willSet {
            self.handleState(newValue == .error)
        }
    }

    init(_ moviesRepo: MoviesRepository) {
        self.moviesRepo = moviesRepo
    }

    func fetchData() async {
        do {
            let _ = try await moviesRepo.getMovies()
            self.isLoading = false
            self.state = .success
        } catch {
            self.state = .error
            print("\(TAG).fetchData() error: ", error)
        }
    }

    private func handleState(_ isError: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            RootViewModel.shared.setAppState(for: isError ? .error : .success)
        }
    }

    internal enum State {
        case success, error, idle
    }
}
