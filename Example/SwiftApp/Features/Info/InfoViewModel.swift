//
//  InfoViewModel.swift
//  SwiftApp
//
//  Created by Jose Julio Junior on 15/09/26.
//

import Foundation

protocol InfoViewModelNotification: AnyObject {
    func didUpdate()
    func handleError(_ error: Error)
}

protocol InfoViewModelService {
    func fetchValues()

    var sceneModel: InfoModel.SceneModel? { get }
    var dataStore: InfoDataStore? { get set }
}

final class InfoViewModel: InfoViewModelService {

    // MARK: - Delegate

    weak var notification: InfoViewModelNotification?

    // MARK: - Properties

    var dataStore: InfoDataStore?
    private let worker: InfoWorkerLogic?
    private(set) var sceneModel: InfoModel.SceneModel?

    // MARK: - Lifecycle

    init(notification: InfoViewModelNotification?, worker: InfoWorkerLogic?) {
        self.notification = notification
        self.worker = worker
    }

    // MARK: - Service

    func fetchValues() {
        // TODO: montar o request a partir do dataStore, se necessário.
        let request = InfoRequest()
        worker?.fetchInfoData(params: request) { [weak self] result in
            switch result {
            case .success(let response):
                self?.handleData(response)
            case .failure(let error):
                self?.notification?.handleError(error)
            }
        }
    }

    // MARK: - Private

    private func handleData(_ response: InfoResponse) {
        // TODO: transformar a response em sceneModel e notificar a view.
        sceneModel = InfoModel.SceneModel(title: InfoKeys.Localized.title.localized)
        notification?.didUpdate()
    }
}
