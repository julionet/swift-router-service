//
//  InitHandler.swift
//  SwiftApp
//
//  Created by Jose Julio Junior on 15/09/26.
//

import Foundation
import SwiftRouterService

final class InitHandler: RouteHandler {
    var routes: [Route.Type] = [
        InitRoute.self
    ]

    init() {}

    func destination(forRoute route: Route) -> Feature.Type {
        guard route is InitRoute else { preconditionFailure() }
        return InitFeature.self
    }
}
