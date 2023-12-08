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
    @Published private(set) var state = AppState.loading

    func setAppState(for state: AppState) {
        self.state = state
    }

    enum AppState {
        case success, error, loading
    }
}
