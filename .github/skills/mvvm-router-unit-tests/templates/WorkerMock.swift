//
//  {Feature}WorkerMock.swift
//  {Module}
//
//  Created by {Author} on {Date}.
//
//  PADRÃO: implementa {Feature}WorkerLogic usando PromiseKit.
//  Controle sucesso/falha com `isSuccess`.
//

import Foundation
import PromiseKit
@testable import {Module}

final class {Feature}WorkerMock: {Feature}WorkerLogic {

    // MARK: - Control Properties

    var isSuccess: Bool = true
    var errorToReject: Error = NSError(domain: "{Feature}WorkerMock", code: -1)

    // MARK: - Response Stub
    // TODO: preencher com um {Response} válido de exemplo
    var mockResponse: {Response}?

    // MARK: - Protocol Implementation
    // TODO: substituir {method}/{Request}/{Response} pelos nomes reais de {Feature}WorkerLogic

    func {method}(params: {Request}) -> Promise<{Response}> {
        Promise { seal in
            guard isSuccess, let mockResponse else {
                seal.reject(errorToReject)
                return
            }
            seal.fulfill(mockResponse)
        }
    }
}
