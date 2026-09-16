//
//  InfoFeature.swift
//  SwiftApp
//
//  Created by Jose Julio Junior on 15/09/26.
//

import UIKit
import SwiftRouterService

final class InfoFeature: Feature {

    @Dependency var routerService: RouterServiceProtocol

    init() {}

    func build(fromRoute route: Route?) -> UIViewController {
        guard let route = route as? InfoRoute else { preconditionFailure() }

        let viewController = InfoViewController(routerService: routerService)

        let worker = InfoWorker()
        let viewModel = InfoViewModel(notification: viewController, worker: worker)
        viewModel.dataStore = route.dataStore
        viewController.viewModel = viewModel

        return viewController
    }
}
