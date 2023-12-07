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

    @Published private(set) var movies = [Movie]()
    @Published var query: String = ""
    private var bag = Set<AnyCancellable>()

    init(_ moviesRepo: MoviesRepository) {
        self.moviesRepo = moviesRepo
        $query
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink { newValue in
                let letters = newValue.filter({ !$0.isWhitespace })
                if letters.count > 0 {
                    //self.updateResult(newValue)
                }
            }
            .store(in: &bag)
    }

    func fetchData() async {
        do {
            let stored = DataController.shared.movies
            if !stored.isEmpty {
                self.movies = stored
                return
            }
            let result = try await moviesRepo.getMovies(title: "batman")
            DataController.shared.movies = result
            self.movies = result
        } catch {
            print("\(TAG).fetchData() error: ", error)
        }
    }
}
