//
//  AppDependencyRegistration.swift
//  SwiftApp
//
//  Created by Jose Julio Junior on 15/09/26.
//

import Foundation
import SwiftRouterService

extension SwiftRouterService.DependencyInjectionFactory {
    public static func make(with routerService: RouterService) {
        routerService.register(dependencyFactory: { routerService }, forType: RouterServiceProtocol.self)
    }
}
