//
//  {Feature}ViewControllerTests.swift
//  {Module}
//
//  Created by {Author} on {Date}.
//

import XCTest
@testable import {Module}
import PanRouterServiceInterface

class {Feature}ViewControllerTests: XCTestCase {

    // MARK: - Variables

    private var sut: {Feature}ViewController!
    private var viewModelSpy: {Feature}ViewModelServiceSpy!

    override func setUp() {
        super.setUp()
        // TODO: usar um RouterServiceProtocol de teste/mock do projeto, se existir
        sut = {Feature}ViewController(routerService: RouterServiceMock())
        viewModelSpy = {Feature}ViewModelServiceSpy()
        sut.viewModel = viewModelSpy
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        sut = nil
        viewModelSpy = nil
        super.tearDown()
    }

    // MARK: - Tests

    func testViewWillAppearFetchesValues() {
        // When
        sut.viewWillAppear(false)

        // Then
        XCTAssertTrue(viewModelSpy.fetchValuesCalled,
            "viewWillAppear deveria chamar viewModel.fetchValues()")
    }

    func testDidUpdateUpdatesScene() {
        // Given
        viewModelSpy.sceneModel = {Feature}Model.SceneModel(title: "Teste")

        // When
        sut.didUpdate()

        // Then
        // TODO: validar o estado da UI após didUpdate(), de acordo com os componentes reais da tela
    }
}
