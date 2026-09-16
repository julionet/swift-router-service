//
//  InitFeature.swift
//  SwiftApp
//
//  Created by Jose Julio Junior on 15/09/26.
//

import UIKit
import SwiftRouterService

final class InitFeature: Feature {

    @Dependency var routerService: RouterServiceProtocol

    init() {}

    func build(fromRoute route: Route?) -> UIViewController {
        guard let route = route as? InitRoute else { preconditionFailure() }

        let viewController = InitViewController(routerService: routerService)

        let worker = InitWorker()
        let viewModel = InitViewModel(notification: viewController, worker: worker)
        viewModel.dataStore = route.dataStore
        viewController.viewModel = viewModel

        return viewController
    }
}
