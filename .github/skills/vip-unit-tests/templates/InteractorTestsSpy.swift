//
//  {Module}InteractorTestsSpy.swift
//  App
//
//  Created by {Author} on {Date}.
//  Copyright (c) {Year}. All rights reserved.
//
//  PADRÃO: Este arquivo é uma extensão da classe de teste do Interactor.
//  O Spy implementa o protocolo PresentationLogic do módulo.
//  Cada método do protocolo seta uma variável booleana `{method}Called = true`.
//

import XCTest
@testable import BancoDigital

extension {Module}InteractorTests {

    // MARK: - PresentationLogic Spy

    class {Module}PresentationLogicSpy: {Module}PresentationLogic {

        // MARK: - Called Flags
        // Adicione uma variável booleana para cada método do protocolo {Module}PresentationLogic

        var present{Action1}Called = false
        var present{Action2}Called = false
        var present{Action3}Called = false
        // var presentLoadingCalled = false
        // var presentErrorCalled = false

        // MARK: - Protocol Implementations
        // Implemente cada método do protocolo setando o respectivo flag

        func present{Action1}() {
            present{Action1}Called = true
        }

        func present{Action2}(response: {Module}.Model.{ResponseType}) {
            present{Action2}Called = true
        }

        func present{Action3}() {
            present{Action3}Called = true
        }

        // func presentLoading(_ isLoading: Bool) {
        //     presentLoadingCalled = true
        // }

        // func presentError(_ error: Error) {
        //     presentErrorCalled = true
        // }
    }
}
