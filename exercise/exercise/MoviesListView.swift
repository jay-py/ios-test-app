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

    @StateObject private var vm: MoviesListViewModel
    @Environment(\.colorScheme) var colorScheme

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
        ScrollView {
            LazyVStack {
                ForEach(vm.movies) {
                    cell($0)
                        .padding(.horizontal, 20)
                    Color.gray.opacity(0.5)
                        .frame(maxWidth: .infinity)
                        .frame(height: 1)
                        .padding(.horizontal, 30)
                }
            }

        }
        .listStyle(DefaultListStyle())
        .listRowInsets(EdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 10))
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
                    .foregroundStyle(colorScheme == .dark ? Color.white : .black)
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
