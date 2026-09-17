//
//  {Feature}Worker.swift
//  SwiftRouterService
//
//  Created by {Author} on {Date}.
//

import Foundation
import BDServiceProviderInterface
import PromiseKit
import PanPaymentGatewayInterface

protocol {Feature}WorkerLogic {
    func fetchData(params: {Feature}Request) -> Promise<{Feature}Response>
}

final class {Feature}Worker: {Feature}WorkerLogic {

    let apiService: APIServiceLogic

    // MARK: - Lifecycle

    init(apiService: APIServiceLogic) {
        self.apiService = apiService
    }

    func fetchData(params: {Feature}Request) -> Promise<{Feature}Response> {
        let request = {Feature}Provider(params: params)

        return Promise<{Feature}Response> { seal in
            apiService.fetch(model: {Feature}Response.self, request: request) { result in
                switch result {
                case .success(let response):
                    seal.fulfill(response)
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
}

// Sem Provider vinculado: caso {Feature}Worker não precise chamar API,
// remova este arquivo e o parâmetro `worker` de {Feature}Feature/{Feature}ViewModel.
