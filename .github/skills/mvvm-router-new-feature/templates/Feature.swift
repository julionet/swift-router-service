//
//  {Feature}Feature.swift
//  PanPaymentGateway
//
//  Created by {Author} on {Date}.
//

import Foundation
import PanPaymentGatewayInterface
import PanRouterServiceInterface
import BDServiceProviderInterface
import CompositionRootInterface

final class {Feature}Feature: Feature {

    @Dependency var routerService: RouterServiceProtocol
    @Dependency var apiService: (APIServiceLogic & APIServiceData)

    func build(fromRoute route: Route?) -> UIViewController {
        guard let route = route as? {Feature}Route else { preconditionFailure() }

        let viewController = {Feature}ViewController(routerService: routerService)
        viewController.modalPresentationStyle = .fullScreen

        let worker = {Feature}Worker(apiService: apiService)

        let viewControllerVM = {Feature}ViewModel(notification: viewController,
                                                  worker: worker)
        viewControllerVM.dataStore = route.dataStore
        viewController.viewModel = viewControllerVM

        return viewController
    }
}
