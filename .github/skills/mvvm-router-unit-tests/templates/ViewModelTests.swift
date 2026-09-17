//
//  {Feature}ViewModelTests.swift
//  {Module}
//
//  Created by {Author} on {Date}.
//

import XCTest
import PromiseKit
@testable import {Module}

class {Feature}ViewModelTests: XCTestCase {

    // MARK: - Variables

    private var sut: {Feature}ViewModel!
    private var notificationSpy: {Feature}ViewModelNotificationSpy!
    private var workerMock: {Feature}WorkerMock! // remova se a feature não tiver Worker

    override func setUp() {
        super.setUp()
        notificationSpy = {Feature}ViewModelNotificationSpy()
        workerMock = {Feature}WorkerMock()
        sut = {Feature}ViewModel(notification: notificationSpy, worker: workerMock)
    }

    override func tearDown() {
        sut = nil
        notificationSpy = nil
        workerMock = nil
        super.tearDown()
    }

    // MARK: - Tests
    // TODO: substituir {Method} pelos métodos reais de {Feature}ViewModelService

    func test{Method}Success() {
        // Given
        workerMock.isSuccess = true
        sut.dataStore = {Feature}DataStore(/* preencher com dados válidos */)

        // When
        let exp = expectation(description: "wait {Method}")
        notificationSpy.didUpdateHandler = { exp.fulfill() }
        sut.{method}()

        // Then
        wait(for: [exp], timeout: 1)
        XCTAssertTrue(notificationSpy.didUpdateCalled,
            "didUpdate() deveria ter sido chamado após {Method} com sucesso")
    }

    func test{Method}Failure() {
        // Given
        workerMock.isSuccess = false
        sut.dataStore = {Feature}DataStore(/* preencher com dados válidos */)

        // When
        let exp = expectation(description: "wait {Method} error")
        notificationSpy.handleErrorHandler = { _ in exp.fulfill() }
        sut.{method}()

        // Then
        wait(for: [exp], timeout: 1)
        XCTAssertTrue(notificationSpy.handleErrorCalled,
            "handleError(...) deveria ter sido chamado após falha em {Method}")
    }
}
