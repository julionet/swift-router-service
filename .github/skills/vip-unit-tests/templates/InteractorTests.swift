//
//  {Module}InteractorTests.swift
//  App
//
//  Created by {Author} on {Date}.
//  Copyright (c) {Year}. All rights reserved.
//

import XCTest
@testable import App

class {Module}InteractorTests: XCTestCase {

    // MARK: - Variables

    private var sut: {Module}Interactor!
    private var spyPresenter: {Module}PresentationLogicSpy!
    // Adicione mocks de dependências:
    // private var workerMock: {Module}WorkerMock!
    // private var remoteConfigMock: RemoteConfigMock!
    // private var userRepositoryMock: UserDataSource!

    override func setUp() {
        super.setUp()
        spyPresenter = {Module}PresentationLogicSpy()
        // workerMock = {Module}WorkerMock()
        // remoteConfigMock = RemoteConfigMock()
        // userRepositoryMock = UserRepositoryMock()
        setupSut()
    }

    override func tearDown() {
        sut = nil
        spyPresenter = nil
        // workerMock = nil
        // remoteConfigMock = nil
        // userRepositoryMock = nil
        super.tearDown()
    }

    private func setupSut() {
        sut = {Module}Interactor(
            // worker: workerMock,
            // remoteConfigService: remoteConfigMock,
            // userRepository: userRepositoryMock
        )
        sut.presenter = spyPresenter
    }

    // MARK: - Tests

    func test{Action}() {
        // Given:
        // let input = ...

        // When:
        sut.{action}(/* input */)

        // Then:
        XCTAssert(spyPresenter.present{Result}Called)
    }

    func test{Action}WithError() {
        // Given:
        // workerMock.isSuccess = false
        // workerMock.errorType = .noConnection

        // When:
        sut.{action}()

        // Then:
        XCTAssert(spyPresenter.present{Error}Called)
    }
}
