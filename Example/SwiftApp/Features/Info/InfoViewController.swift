//
//  InfoViewController.swift
//  SwiftApp
//
//  Created by Jose Julio Junior on 15/09/26.
//

import UIKit
import SwiftRouterService

final class InfoViewController: UIViewController {

    // MARK: - Router Service

    private let routerService: RouterServiceProtocol?

    // MARK: - View Model

    var viewModel: InfoViewModelService?

    private let screenView = InfoView()

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

    // TODO: métodos privados de navegação (routeTo...) que constroem o
    // próximo Route e chamam
    // routerService?.navigate(toRoute:fromView:presentationStyle:animated:)
}

extension InfoViewController: InfoViewModelNotification {
    func didUpdate() {
        updateScene()
    }

    func handleError(_ error: Error) {
        // TODO: tratar o erro (ex: exibir alerta ou navegar para uma tela de erro).
    }
}

extension InfoViewController: InfoViewDelegate {
    // TODO: implemente aqui as ações delegadas pela InfoView
}
