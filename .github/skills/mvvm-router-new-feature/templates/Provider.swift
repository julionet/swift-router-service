//
//  {Feature}Provider.swift
//  PanPaymentGateway
//
//  Created by {Author} on {Date}.
//

import BDServiceProviderInterface
import BDServiceProvider
import PanPaymentGatewayInterface

final class {Feature}Provider: RequestProvider {

    var httpMethod: RequestHTTPMethod { .get }
    var path: String { "" } // TODO: preencher o path do endpoint

    let params: {Feature}Request

    init(params: {Feature}Request) {
        self.params = params
    }

    var headers: [String: String] {
        // TODO: montar os headers/parâmetros exigidos pelo endpoint
        [:]
    }
}
