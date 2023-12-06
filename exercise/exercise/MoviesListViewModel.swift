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
    
    @Published private(set) var movies = [Movie.MovieItem]()
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
            let result = try await moviesRepo.getMovies(title: "batman", page: 1)
            self.movies.append(contentsOf: result.items)
        } catch {
            print("\(TAG).fetchData() error: ", error)
        }
    }
    
    
}
