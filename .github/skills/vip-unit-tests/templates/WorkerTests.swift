//
//  {Module}WorkerTests.swift
//  App
//
//  Created by {Author} on {Date}.
//  Copyright (c) {Year} Banco Pan SA. All rights reserved.
//

import XCTest
import PromiseKit
import BDServiceProviderInterface
@testable import BancoDigital

class {Module}WorkerTests: XCTestCase {

    // MARK: - Variables

    private var worker: {Module}Worker!
    private var apiServiceMock: APIServiceLogicMock!

    override func setUp() {
        super.setUp()
        apiServiceMock = APIServiceLogicMock()
        worker = {Module}Worker(apiService: apiServiceMock)
    }

    override func tearDown() {
        worker = nil
        apiServiceMock = nil
        super.tearDown()
    }

    // MARK: - Tests

    func test{Operation}Success() {
        // Given
        let expectedResponse = {Module}.Model.Response(/* ... */)
        apiServiceMock.fetchResponse = expectedResponse

        // When
        let exp = expectation(description: "wait response")
        var receivedValue: {Module}.Model.Response?
        worker.{operation}().done { result in
            receivedValue = result
            exp.fulfill()
        }.catch { _ in
            exp.fulfill()
        }

        // Then
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(receivedValue)
    }

    func test{Operation}Failure() {
        // Given
        apiServiceMock.fetchError = .noConnection

        // When
        let promise = worker.{operation}()
        let exp = expectation(
            for: NSPredicate(value: true),
            evaluatedWith: promise.error,
            handler: nil
        )

        // Then
        wait(for: [exp], timeout: 5)
        let error = promise.error as? APIError
        switch error {
        case .noConnection:
            XCTAssertTrue(true)
        default:
            XCTFail("Unexpected error: \(String(describing: error))")
        }
    }
}
