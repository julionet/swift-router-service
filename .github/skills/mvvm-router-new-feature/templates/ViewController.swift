//
//  {Feature}ViewController.swift
//  PanPaymentGateway
//
//  Created by {Author} on {Date}.
//

import UIKit
import PanRouterServiceInterface
import PanPaymentGatewayInterface

final class {Feature}ViewController: UIViewController {

    // MARK: - Router Service

    private let routerService: RouterServiceProtocol?

    // MARK: - View Model

    var viewModel: {Feature}ViewModelService?

    private let screenView = {Feature}View()

    // MARK: - Lifecycle

    override func loadView() {
        view = screenView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        screenView.delegate = self
        viewModel?.fetchValues()
    }

    public init(routerService: RouterServiceProtocol) {
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
    // próximo {NextFeature}Route/{NextFeature}DataStore e chamam
    // routerService?.navigate(toRoute:fromView:presentationStyle:animated:)
}

extension {Feature}ViewController: {Feature}ViewModelNotification {
    func didUpdate() {
        updateScene()
    }

    func handleError(error: PaymentAnalyticsErrorModel?) {
        // TODO: navegar para a tela de erro (ex: PaymentErrorRoute) se aplicável.
    }
}

extension {Feature}ViewController: {Feature}ViewDelegate {
    // TODO: implemente aqui as ações delegadas pela {Feature}View
}
