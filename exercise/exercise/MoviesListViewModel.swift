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
    @Published var query: String = ""
    private var storedMovies = [Movie]()

    init(_ moviesRepo: MoviesRepository) {
        self.moviesRepo = moviesRepo
        $query
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { newValue in
                self.filterMovies(query: newValue)
            }
            .store(in: &bag)
    }

    func fetchData() async {
        if self.movies.isEmpty,
            let res = try? await moviesRepo.getMovies()
        {
            self.storedMovies = res
            self.setMovies(default: true)
        }
    }

    internal func filterMovies(query: String) {
        if query.isEmpty {
            self.setMovies(default: true)
        } else {
            let matches = storedMovies.filter {
                $0.title.lowercased().contains(query.lowercased())
                    || $0.released.lowercased().contains(query.lowercased())
            }
            print(">> Matches found: ", matches.count)
            self.setMovies(matches)
        }
    }

    private func setMovies(_ movies: [Movie]? = nil, default: Bool = false) {
        withAnimation {
            if `default` {
                if self.movies != self.storedMovies {
                    self.movies = self.storedMovies
                }
            } else {
                if let res = movies,
                    res != self.movies
                {
                    self.movies = res
                }
            }
        }
    }
}
