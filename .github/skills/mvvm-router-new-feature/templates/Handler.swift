//
//  {Feature}Handler.swift
//  PanPaymentGateway
//
//  Created by {Author} on {Date}.
//

import Foundation
import PanRouterServiceInterface
import PanPaymentGatewayInterface

public final class {Feature}Handler: RouteHandler {
    public var routes: [Route.Type] = [
        {Feature}Route.self
    ]

    public init() {}

    public func destination(forRoute route: Route) -> Feature.Type {
        guard route is {Feature}Route else { preconditionFailure() }
        return {Feature}Feature.self
    }
}
