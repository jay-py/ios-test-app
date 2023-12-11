//
//  SplashViewModelTests.swift
//  exerciseTests
//
//  Created by Jean paul on 2023-12-11.
//

import Combine
import XCTest

@testable import Domain
@testable import exercise

@MainActor final class SplashViewModelTests: XCTestCase {

    let viewModel = SplashViewModel(MoviesRepository())
    var cancellable: Set<AnyCancellable> = []

    override func tearDownWithError() throws {
        cancellable.forEach { $0.cancel() }
    }

    func testStateWhenDataPopulated() async throws {
        try? await Task.sleep(nanoseconds: 5_000_000_000)  // wait for default init
        let fetched = XCTestExpectation(description: "Data fetched successfully")
        let cancellable = viewModel.$isLoading.sink { value in
            if !value {  // avoid initial empty setter call
                fetched.fulfill()
            }
        }
        XCTAssertTrue(viewModel.state == .idle)
        await viewModel.fetchData()
        await fulfillment(of: [fetched], timeout: 1)
        cancellable.cancel()
        XCTAssertTrue(viewModel.state == .success)
    }
}
