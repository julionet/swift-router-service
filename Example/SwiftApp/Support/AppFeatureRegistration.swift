//
//  AppFeatureRegistration.swift
//  SwiftApp
//
//  Created by Jose Julio Junior on 15/09/26.
//

import Foundation
import SwiftRouterService

extension SwiftRouterService.RouteHandlerFactory {
    public static func make(with routerService: RouterService) {
        routerService.register(routeHandler: InitHandler())
        routerService.register(routeHandler: InfoHandler())
    }
}
