//
//  {Feature}ViewController.swift
//  App
//
//  Created by {Author} on {Date}.
//

import UIKit

protocol {Feature}DisplayLogic: AnyObject {
    func displayScreenValues(viewModel: {Feature}.Model.ViewModel)
}

final class {Feature}ViewController: UIViewController {
    
    // MARK: - Archtecture Objects
    
    var interactor: {Feature}BusinessLogic?
    var router: (NSObjectProtocol & {Feature}RoutingLogic & {Feature}DataPassing)?
    
    private let screenView = {Feature}View()
    
    // MARK: - ViewController Lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func loadView() {
        view = screenView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadScreenValues()
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = {Feature}Interactor()
        let presenter = {Feature}Presenter()
        let router = {Feature}Router()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        screenView.delegate = viewController
    }
    
    // MARK: - Private Functions
    
    private func loadScreenValues() {
        interactor?.loadScreenValues()
    }
}

extension {Feature}ViewController: {Feature}DisplayLogic {
    
    func displayScreenValues(viewModel: {Feature}.Model.ViewModel) {
        screenView.setup(model: viewModel)
    }
}

extension {Feature}ViewController: {Feature}Delegate {
    
    // TODO: implemente aqui as ações delegadas pela {Feature}View
}
