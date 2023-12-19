//
//  exerciseTests.swift
//  exerciseTests
//
//  Created by Jean paul on 2023-12-05.
//

import Combine
import XCTest

@testable import Domain
@testable import exercise

@MainActor final class MoviesListViewModelTests: XCTestCase {

    fileprivate let viewModel = MoviesListViewModel(MoviesRepository())
    fileprivate var cancellables: Set<AnyCancellable> = []
    fileprivate enum Status { case idle, searching }

    override func tearDownWithError() throws {
        cancellables.forEach { $0.cancel() }
    }

    func testDataPopulation() async throws {
        try? await Task.sleep(nanoseconds: 5_000_000_000)  // wait for default init
        let retrieved = XCTestExpectation(description: "Data retrieved successfully")
        let cancellable = viewModel.$movies.sink { movies in
            if !movies.isEmpty {  // avoid initial empty setter call
                retrieved.fulfill()
            }
        }
        XCTAssertTrue(viewModel.movies.isEmpty)
        await viewModel.fetchData()
        await fulfillment(of: [retrieved], timeout: 1)
        cancellable.cancel()
        XCTAssertFalse(viewModel.movies.isEmpty)
    }

    func testValidFiltering() async throws {
        //  title: Batman v Superman: Dawn of Justice (Ultimate Edition),
        //  release: 23 Mar 2016
        var status = Status.idle
        let validYearQuery = "2016"
        let validYearExpectation = XCTestExpectation(description: "Data filtered successfully")
        let expectedFound = 4  // duplicated data; same!

        let cancellable = viewModel.$movies.sink { movies in
            if movies.isEmpty && status == .idle {  // avoid initial empty setter call
                status = .searching
            } else {
                if movies.count == expectedFound {
                    validYearExpectation.fulfill()
                }
            }
        }
        await viewModel.fetchData()
        viewModel.filterMovies(query: validYearQuery)
        await fulfillment(of: [validYearExpectation], timeout: 1)
        cancellable.cancel()
        XCTAssertFalse(viewModel.movies.isEmpty)
    }

    func testInvalidFiltering() async throws {
        //  title: Batman v Superman: Dawn of Justice (Ultimate Edition),
        //  release: 23 Mar 2016
        var status = Status.idle
        let invalidTitleQuery = "Joker"
        let invalidTitleExpectation = XCTestExpectation(description: "Data filtered successfully")
        let expectedNotFound = 0

        let cancellable = viewModel.$movies.sink { movies in
            if movies.isEmpty && status == .idle {  // avoid initial empty setter call
                status = .searching
            } else {
                if movies.count == expectedNotFound {
                    invalidTitleExpectation.fulfill()
                }
            }
        }
        await viewModel.fetchData()
        viewModel.filterMovies(query: invalidTitleQuery)
        await fulfillment(of: [invalidTitleExpectation], timeout: 1)
        cancellable.cancel()
        XCTAssertTrue(viewModel.movies.isEmpty)
    }
}
