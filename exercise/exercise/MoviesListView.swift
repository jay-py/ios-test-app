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
                ForEach(vm.filteredMovies ?? vm.movies) {
                    cell($0)
                        .padding(.horizontal, 20)
                    Color.gray.opacity(0.5)
                        .frame(maxWidth: .infinity)
                        .frame(height: 1)
                        .padding(.horizontal, 30)
                }
            }
        }
        .task {
            await vm.fetchData()
        }
    }

    @ViewBuilder
    func cell(_ item: Movie) -> some View {

        Button {
            print(item)
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
                    .foregroundStyle(Color.fontColor(isLightMode))
                Spacer()

            }
            .padding(8)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .strokeBorder(lineWidth: 3)
                    .foregroundColor(.themeColor)
            )
            .padding(.vertical, 8)
        }

    }
}

#Preview {
    MoviesListView(MoviesRepository())
}
