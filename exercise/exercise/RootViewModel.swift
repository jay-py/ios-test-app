//
//  RootViewModel.swift
//  exercise
//
//  Created by Jean paul on 2023-12-06.
//

import SwiftUI

@MainActor
final class RootViewModel: ObservableObject {

    static let shared = RootViewModel()
    private init() {}
    @Published private(set) var rootView: Screen = .splash

    func setRootView(screen: Screen) {
        self.rootView = screen
    }
}

extension RootViewModel {
    enum Screen {
        case splash, home
    }
}
