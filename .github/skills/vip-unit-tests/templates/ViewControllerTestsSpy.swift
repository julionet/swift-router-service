//
//  {Module}ViewControllerTestsSpy.swift
//  App
//
//  Created by {Author} on {Date}.
//  Copyright (c) {Year}. All rights reserved.
//
//  PADRÃO: Este arquivo é uma extensão da classe de teste do ViewController.
//  Contém dois Spies:
//    1. {Module}BusinessLogicSpy — implementa BusinessLogic para interceptar chamadas ao Interactor
//    2. {Module}RouterSpy — implementa RoutingLogic + DataPassing para interceptar navegação
//

import XCTest
@testable import App

extension {Module}ViewControllerTests {

    // MARK: - BusinessLogic Spy
    // Spy que implementa o BusinessLogic para testar chamadas da ViewController ao Interactor

    class {Module}BusinessLogicSpy: {Module}BusinessLogic {

        // MARK: - Called Flags
        // Adicione uma variável booleana para cada método do protocolo {Module}BusinessLogic

        var load{Screen}Called = false
        var did{Action1}Called = false
        var did{Action2}Called = false

        // MARK: - Protocol Implementations

        func load{Screen}() {
            load{Screen}Called = true
        }

        func did{Action1}() {
            did{Action1}Called = true
        }

        func did{Action2}(request: {Module}.Model.Request) {
            did{Action2}Called = true
        }
    }

    // MARK: - RoutingLogic Spy
    // RouterSpy herda de NSObject e implementa DOIS protocolos: RoutingLogic e DataPassing

    class {Module}RouterSpy: NSObject, {Module}RoutingLogic, {Module}DataPassing {

        var dataStore: {Module}DataStore?

        // MARK: - Called Flags
        // Adicione uma variável booleana para cada método do protocolo {Module}RoutingLogic

        var routeTo{Scene1}Called = false
        var routeTo{Scene2}Called = false
        var routeBackCalled = false
        var dismissNavigationCalled = false

        // MARK: - Protocol Implementations

        func routeTo{Scene1}() {
            routeTo{Scene1}Called = true
        }

        func routeTo{Scene2}() {
            routeTo{Scene2}Called = true
        }

        func routeBack() {
            routeBackCalled = true
        }

        func dismissNavigation() {
            dismissNavigationCalled = true
        }
    }
}
