//
//  {Module}PresenterTests.swift
//  App
//
//  Created by {Author} on {Date}.
//  Copyright (c) {Year}. All rights reserved.
//

import XCTest
@testable import BancoDigital

class {Module}PresenterTests: XCTestCase {

    // MARK: - Variables

    private var sut: {Module}Presenter!
    private var spyController: {Module}DisplayLogicSpy!

    override func setUp() {
        super.setUp()
        spyController = {Module}DisplayLogicSpy()
        setupSut()
    }

    override func tearDown() {
        sut = nil
        spyController = nil
        super.tearDown()
    }

    private func setupSut() {
        sut = {Module}Presenter()
        sut.viewController = spyController
    }

    // MARK: - Tests

    func test{Display}() {
        // Given:
        // let response = {Module}.Model.Response(...)

        // When:
        sut.present{Something}(/* response */)

        // Then:
        XCTAssertEqual(spyController.display{Something}Called, true)
    }

    func test{Display}WithError() {
        // When:
        sut.present{Error}()

        // Then:
        XCTAssertEqual(spyController.display{Error}Called, true)
    }
}
