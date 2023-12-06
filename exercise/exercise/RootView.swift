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
        screen(for: vm.rootView)
    }

    @ViewBuilder
    private func screen(for screen: RootViewModel.Screen) -> some View {
        switch screen {
            case .splash:
                SplashView(moviesRepository)
            case .home:
                MoviesListView(moviesRepository)
        }
    }
}
