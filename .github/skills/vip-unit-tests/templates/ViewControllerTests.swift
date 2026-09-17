//
//  {Module}ViewControllerTests.swift
//  App
//
//  Created by {Author} on {Date}.
//  Copyright (c) {Year} Banco Pan SA. All rights reserved.
//

import XCTest
@testable import App

class {Module}ViewControllerTests: XCTestCase {

    // MARK: - Variables

    private var sut: {Module}ViewController!
    private var spyInteractor: {Module}BusinessLogicSpy!
    private var spyRouter: {Module}RouterSpy!
    private var windowScene: UIWindow?

    override func setUp() {
        super.setUp()
        spyInteractor = {Module}BusinessLogicSpy()
        spyRouter = {Module}RouterSpy()
        setupSut()
    }

    override func tearDown() {
        sut = nil
        spyInteractor = nil
        spyRouter = nil
        windowScene = nil
        super.tearDown()
    }

    private func setupSut() {
        sut = {Module}ViewController(nibName: nil, bundle: nil)
        sut.interactor = spyInteractor
        sut.router = spyRouter
        UIWindow().makeKey()
        _ = sut.view
    }

    func loadView() {
        windowScene = UIWindow()
        windowScene?.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: - Tests

    func testRouteTo{Scene}() {
        // When:
        sut.display{Something}()

        // Then:
        XCTAssert(spyRouter.routeTo{Scene}Called)
    }

    func test{Action}CallsInteractor() {
        // When:
        sut.{userAction}()

        // Then:
        XCTAssert(spyInteractor.{method}Called)
    }
}
