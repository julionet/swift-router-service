//
//  {Feature}WorkerTests.swift
//  {Module}
//
//  Created by {Author} on {Date}.
//

import XCTest
import PromiseKit
import BDServiceProviderInterface
@testable import {Module}

class {Feature}WorkerTests: XCTestCase {

    // MARK: - Variables

    private var sut: {Feature}Worker!
    private var apiServiceMock: APIServiceLogicMock! // TODO: confirmar mock real de APIServiceLogic usado no projeto

    override func setUp() {
        super.setUp()
        apiServiceMock = APIServiceLogicMock()
        sut = {Feature}Worker(apiService: apiServiceMock)
    }

    override func tearDown() {
        sut = nil
        apiServiceMock = nil
        super.tearDown()
    }

    // MARK: - Tests
    // TODO: substituir {method}/{Request}/{Response} pelos nomes reais de {Feature}WorkerLogic

    func test{Method}Success() {
        // Given
        let expectedResponse = {Response}(/* preencher com dados válidos */)
        apiServiceMock.fetchResponse = expectedResponse

        // When
        let exp = expectation(description: "wait {method}")
        var receivedValue: {Response}?
        sut.{method}(params: {Request}(/* preencher */))
            .done { response in
                receivedValue = response
                exp.fulfill()
            }
            .catch { _ in exp.fulfill() }

        // Then
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(receivedValue, "{method} deveria retornar uma resposta válida")
    }

    func test{Method}Failure() {
        // Given
        apiServiceMock.fetchError = .noConnection

        // When
        let exp = expectation(description: "wait {method} error")
        var receivedError: Error?
        sut.{method}(params: {Request}(/* preencher */))
            .done { _ in exp.fulfill() }
            .catch { error in
                receivedError = error
                exp.fulfill()
            }

        // Then
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(receivedError, "{method} deveria propagar o erro da API")
    }
}
