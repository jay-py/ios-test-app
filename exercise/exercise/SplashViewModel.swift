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
    @Published private(set) var isLoading: Bool = true
    @Published private var state: State = .idle
    private var bag = Set<AnyCancellable>()

    init(_ moviesRepo: MoviesRepository) {
        self.moviesRepo = moviesRepo
        $state
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink { newValue in
                self.handleState(newValue == .error)
            }
            .store(in: &bag)
    }

    @MainActor
    func fetchData() async {
        do {
            if let stored = await DataController.shared.getMovies(),
                !stored.isEmpty
            {
                self.isLoading = false
                self.state = .success
                return
            }
            let res = try await moviesRepo.getMovies()
            await DataController.shared.cacheMovies(res)
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

    private enum State {
        case success, error, idle
    }
}
