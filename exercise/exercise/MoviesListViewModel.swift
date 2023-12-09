//
//  MoviesListViewModel.swift
//  exercise
//
//  Created by Jean paul on 2023-12-06.
//
import Combine
import Domain
import SwiftUI

@MainActor
final class MoviesListViewModel: ObservableObject {
    private let TAG = "MoviesListViewModel"
    private let moviesRepo: MoviesRepository
    private var bag = Set<AnyCancellable>()

    @Published private(set) var movies = [Movie]()
    @Published private(set) var filteredMovies: [Movie]?
    @Published var query: String = ""

    init(_ moviesRepo: MoviesRepository) {
        self.moviesRepo = moviesRepo
        $query
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { newValue in
                let letters = newValue.filter({ !$0.isWhitespace })
                if letters.count > 0 {
                    self.filterMovies(query: newValue)
                } else {
                    self.filteredMovies = nil
                }
            }
            .store(in: &bag)
    }

    @MainActor
    func fetchData() async {
        if self.movies.isEmpty,
            let stored = await DataController.shared.getMovies()
        {
            self.movies = stored
        }
    }

    @MainActor
    private func filterMovies(query: String) {
        let matches = movies.filter {
            $0.title.lowercased().contains(query.lowercased())
                || $0.released.lowercased().contains(query.lowercased())
        }
        self.filteredMovies =
            matches.isEmpty
            ? []
            : matches
    }
}
