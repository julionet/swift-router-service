//
//  {Module}PresenterTestsSpy.swift
//  BancoDigital
//
//  Created by {Author} on {Date}.
//  Copyright (c) {Year}. All rights reserved.
//
//  PADRÃO: Este arquivo é uma extensão da classe de teste do Presenter.
//  O Spy implementa o protocolo DisplayLogic do módulo.
//  Cada método do protocolo seta uma variável booleana `{method}Called = true`.
//

import XCTest
@testable import BancoDigital

extension {Module}PresenterTests {

    // MARK: - DisplayLogic Spy

    class {Module}DisplayLogicSpy: {Module}DisplayLogic {

        // MARK: - Called Flags
        // Adicione uma variável booleana para cada método do protocolo {Module}DisplayLogic

        var display{Action1}Called = false
        var display{Action2}Called = false
        var display{Action3}Called = false
        // var displayLoadingCalled = false
        // var displayErrorCalled = false

        // MARK: - Protocol Implementations
        // Implemente cada método do protocolo setando o respectivo flag

        func display{Action1}() {
            display{Action1}Called = true
        }

        func display{Action2}(viewModel: {Module}.Model.ViewModel) {
            display{Action2}Called = true
        }

        func display{Action3}() {
            display{Action3}Called = true
        }

        // func displayLoading(_ isLoading: Bool) {
        //     displayLoadingCalled = true
        // }

        // func displayError() {
        //     displayErrorCalled = true
        // }
    }
}
