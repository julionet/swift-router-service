//
//  InitViewModel.swift
//  SwiftApp
//
//  Created by Jose Julio Junior on 15/09/26.
//

import Foundation

protocol InitViewModelNotification: AnyObject {
    func didUpdate()
    func handleError(_ error: Error)
}

protocol InitViewModelService {
    func fetchValues()

    var sceneModel: InitModel.SceneModel? { get }
    var dataStore: InitDataStore? { get set }
}

final class InitViewModel: InitViewModelService {

    // MARK: - Delegate

    weak var notification: InitViewModelNotification?

    // MARK: - Properties

    var dataStore: InitDataStore?
    private let worker: InitWorkerLogic?
    private(set) var sceneModel: InitModel.SceneModel?

    // MARK: - Lifecycle

    init(notification: InitViewModelNotification?, worker: InitWorkerLogic?) {
        self.notification = notification
        self.worker = worker
    }

    // MARK: - Service

    func fetchValues() {
        // TODO: montar o request a partir do dataStore, se necessário.
        let request = InitRequest()
        worker?.fetchInitData(params: request) { [weak self] result in
            switch result {
            case .success(let response):
                self?.handleData(response)
            case .failure(let error):
                self?.notification?.handleError(error)
            }
        }
    }

    // MARK: - Private

    private func handleData(_ response: InitResponse) {
        // TODO: transformar a response em sceneModel e notificar a view.
        sceneModel = InitModel.SceneModel(
            title: InitKeys.Localized.title.localized,
            buttonText: InitKeys.Localized.buttonText.localized
        )
        notification?.didUpdate()
    }
}
