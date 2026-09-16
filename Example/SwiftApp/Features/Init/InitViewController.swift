//
//  InitViewController.swift
//  SwiftApp
//
//  Created by Jose Julio Junior on 15/09/26.
//

import UIKit
import SwiftRouterService

final class InitViewController: UIViewController {

    // MARK: - Router Service

    private let routerService: RouterServiceProtocol?

    // MARK: - View Model

    var viewModel: InitViewModelService?

    private let screenView = InitView()

    // MARK: - Lifecycle

    override func loadView() {
        view = screenView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        screenView.delegate = self
        viewModel?.fetchValues()
    }

    init(routerService: RouterServiceProtocol) {
        self.routerService = routerService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.routerService = nil
        super.init(coder: coder)
    }

    // MARK: - Private Functions

    private func updateScene() {
        guard let sceneModel = viewModel?.sceneModel else { return }
        screenView.setup(model: sceneModel)
    }

    // MARK: - Navigation

    private func routeToInfo() {
        guard let routerService = routerService else { return }
        let dataStore = InfoDataStore()
        let route = InfoRoute(dataStore: dataStore)
        routerService.navigate(toRoute: route, fromView: self, presentationStyle: Push(), animated: true)
    }
}

extension InitViewController: InitViewModelNotification {
    func didUpdate() {
        updateScene()
    }

    func handleError(_ error: Error) {
        // TODO: tratar o erro (ex: exibir alerta ou navegar para uma tela de erro).
    }
}

extension InitViewController: InitViewDelegate {
    
    func didTapButton() {
        routeToInfo()
    }
}
