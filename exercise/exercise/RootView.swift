//
//  ContentView.swift
//  exercise
//
//  Created by Jean paul on 2023-12-05.
//

import SwiftUI

struct RootView: View {
    @Environment(\.moviesRepository) private var moviesRepository
    @StateObject private var vm = RootViewModel.shared

    var body: some View {
        screen(for: vm.state)
    }

    @ViewBuilder
    private func screen(for state: RootViewModel.AppState) -> some View {
        switch state {
            case .loading:
                SplashView(moviesRepository)
            case .success:
                MoviesListView(moviesRepository)
            case .error:
                Text("no_data_message")
        }
    }
}
