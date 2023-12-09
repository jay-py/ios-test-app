//
//  MoviesListView.swift
//  exercise
//
//  Created by Jean paul on 2023-12-06.
//

import Design
import Domain
import SwiftUI

struct MoviesListView: View {
    @AppStorage("isLightMode") private var isLightMode: Bool = false
    @StateObject private var vm: MoviesListViewModel

    init(_ moviesRepo: MoviesRepository) {
        self._vm = StateObject(
            wrappedValue:
                MoviesListViewModel(moviesRepo))
    }

    var body: some View {
        NavigationStack {
            content
                .task(priority: .high) {
                    await vm.fetchData()
                }
                .searchable(
                    text: $vm.query,
                    placement: .navigationBarDrawer(displayMode: .automatic),
                    prompt: "search_placeholder"
                )
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            withAnimation {
                                isLightMode.toggle()
                            }
                        } label: {
                            Image(systemName: isLightMode ? "moon.fill" : "sun.max.fill")
                                .foregroundStyle(Color.themeColor)
                                .rotationEffect(.degrees(isLightMode ? 0 : 180))
                        }

                    }
                }
                .navigationTitle("navigation_title")
        }
        .tint(Color.themeColor)
        .preferredColorScheme(isLightMode ? .light : .dark)
        .environment(\.colorScheme, isLightMode ? .light : .dark)
        .searchBarTint()
    }

    var content: some View {
        List {
            ForEach(vm.filteredMovies ?? vm.movies) { movie in
                NavigationLink {
                    DetailsView(
                        title: movie.title, image: movie.image, genre: movie.genre,
                        released: movie.released, plot: movie.plot)
                } label: {
                    CellView(text: movie.displayTitle, image: movie.image)
                }
                Divider()
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

#Preview {
    MoviesListView(MoviesRepository())
}
