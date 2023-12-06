//
//  SplashView.swift
//  exercise
//
//  Created by Jean paul on 2023-12-06.
//

import Design
import Domain
import SwiftUI

struct SplashView: View {
    @StateObject private var vm: SplashViewModel

    init(_ moviesRepo: MoviesRepository) {
        self._vm = StateObject(
            wrappedValue:
                SplashViewModel(moviesRepo))
    }

    var body: some View {
        VStack {
            Spacer()
            Text("splash_title")
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .font(.system(size: 50, weight: .bold, design: .default))
                .opacity(vm.isLoading ? 1 : 0)
                .scaleEffect(vm.isLoading ? 1.0 : 1.75)
                .animation(.easeInOut(duration: 1), value: vm.isLoading)
            Spacer()
        }
        .backgroundColor()
        .onChange(of: vm.isLoading) { newValue in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                RootViewModel.shared.setRootView(screen: .home)
            }
        }
        .task {
            await vm.fetchData()
        }

    }
}

#Preview {
    return SplashView(MoviesRepository(mockData: true))
}
