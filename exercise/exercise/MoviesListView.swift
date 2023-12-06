//
//  MoviesListView.swift
//  exercise
//
//  Created by Jean paul on 2023-12-06.
//

import Domain
import Design
import SwiftUI

struct MoviesListView: View {
    
    @StateObject private var vm: MoviesListViewModel

    init(_ moviesRepo: MoviesRepository) {
        self._vm = StateObject(
            wrappedValue:
                MoviesListViewModel(moviesRepo))
    }
    
    var body: some View {
        NavigationStack {
            content
                .searchable(
                    text: $vm.query,
                    placement: .navigationBarDrawer(displayMode: .automatic),
                    prompt: "search_placeholder"
                )
                .navigationTitle("navigation_title")
        }
    }
    
    var content: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack {
                ForEach(vm.movies) {
                    cell($0)
                }
            }
        }
        .task {
            await vm.fetchData()
        }
    }
    
    @ViewBuilder
    func cell(_ item: Movie.MovieItem) -> some View {
        Button {
            print(item.imdbID)
        } label: {
            HStack(spacing: 10) {
                AsyncImage(url: item.imageURL) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 100)
                .background(Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                Spacer()
                Text(item.displayTitle)
                    .fontWeight(.medium)
                    .foregroundStyle(.white)
                Spacer()
                
            }
            .padding(8)
            .frame(maxWidth: .infinity)
            .background (
                RoundedRectangle(cornerRadius: 5)
                    .strokeBorder(lineWidth: 3)
                    .foregroundColor(.themeColor)
            )
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
    }
}
