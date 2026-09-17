//
//  {Module}WorkerMock.swift
//  App
//
//  Created by {Author} on {Date}.
//  Copyright (c) {Year}. All rights reserved.
//
//  PADRÃO: WorkerMock implementa o WorkerLogic do módulo usando PromiseKit.
//  Controle sucesso/falha com `isSuccess` e `errorType`.
//

import Foundation
import PromiseKit
@testable import BancoDigital

class {Module}WorkerMock: {Module}WorkerLogic {

    // MARK: - Control Properties

    var isSuccess: Bool = true
    var errorType: APIError?

    // MARK: - Response Stubs
    // Defina respostas mockadas para cada operação do Worker

    // var mockResponse: {Module}.Model.Response?

    // MARK: - Protocol Implementations
    // Implemente cada método do protocolo {Module}WorkerLogic

    func {operation}() -> Promise<{Module}.Model.Response> {
        return Promise { seal in
            guard isSuccess else {
                seal.reject(errorType ?? APIError.unknown)
                return
            }
            let response = {Module}.Model.Response(/* preencha com dados mockados */)
            seal.fulfill(response)
        }
    }

    func {operationWithParam}(param: {ParamType}) -> Promise<{Module}.Model.{OtherResponseType}> {
        return Promise { seal in
            guard isSuccess else {
                seal.reject(errorType ?? APIError.unknown)
                return
            }
            // Retorne dados mockados adequados
            seal.fulfill(/* mock value */)
        }
    }
}
