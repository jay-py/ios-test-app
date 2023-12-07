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
    @AppStorage("isLightMode") private var isLightMode: Bool = true
    @StateObject private var vm: MoviesListViewModel
    
    init(_ moviesRepo: MoviesRepository) {
        self._vm = StateObject(
            wrappedValue:
                MoviesListViewModel(moviesRepo))
    }

    var body: some View {
        NavigationStack {
            content
                .listBackgroundColor()
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
        .environment(\.colorScheme, isLightMode ? .light : .dark)
        .cutomNavigationBar(isLightModeOn: isLightMode)
    }

    var content: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack {
                ForEach(vm.filteredMovies ?? vm.movies) { movie in
                    NavigationLink {
                        DetailsView(text: movie.displayTitle)
                    } label: {
                        CellView(text: movie.displayTitle, imageUrl: movie.imageURL)
                    }
                    Divider()
                }
            }
            .padding(.horizontal, 20)
        }
        .task {
            await vm.fetchData()
        }
    }
}

#Preview {
    MoviesListView(MoviesRepository())
}
