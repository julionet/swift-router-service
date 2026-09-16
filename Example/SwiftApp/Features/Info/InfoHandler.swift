//
//  InfoHandler.swift
//  SwiftApp
//
//  Created by Jose Julio Junior on 15/09/26.
//

import Foundation
import SwiftRouterService

final class InfoHandler: RouteHandler {
    var routes: [Route.Type] = [
        InfoRoute.self
    ]

    init() {}

    func destination(forRoute route: Route) -> Feature.Type {
        guard route is InfoRoute else { preconditionFailure() }
        return InfoFeature.self
    }
}
