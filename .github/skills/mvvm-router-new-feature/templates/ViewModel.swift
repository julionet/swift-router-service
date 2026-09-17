//
//  {Feature}ViewModel.swift
//  PanPaymentGateway
//
//  Created by {Author} on {Date}.
//

import Foundation
import PanPaymentGatewayInterface

protocol {Feature}ViewModelNotification: AnyObject {
    func didUpdate()
    func handleError(error: PaymentAnalyticsErrorModel?)
}

protocol {Feature}ViewModelService {
    func fetchValues()

    var sceneModel: {Feature}Model.SceneModel? { get }
    var dataStore: {Feature}DataStore? { get }
}

final class {Feature}ViewModel: {Feature}ViewModelService {

    // MARK: - Delegate

    weak var notification: {Feature}ViewModelNotification?

    // MARK: - Properties

    public var dataStore: {Feature}DataStore?
    var worker: {Feature}WorkerLogic?
    var sceneModel: {Feature}Model.SceneModel?

    // MARK: - LifeCycle

    init(notification: {Feature}ViewModelNotification?,
         worker: {Feature}WorkerLogic?) {
        self.notification = notification
        self.worker = worker
    }

    // MARK: - Service

    func fetchValues() {
        // TODO: montar o request a partir do dataStore e chamar o worker.
        // worker?.fetchData(params: ...)
        //     .done(handleData)
        //     .catch(handleError)
    }

    // MARK: - Private

    private func handleData(response: {Feature}Response) {
        // TODO: transformar a response em sceneModel e notificar a view.
        notification?.didUpdate()
    }

    private func handleError(error: Error) {
        // TODO: extrair o PaymentAnalyticsErrorModel a partir do error.
        notification?.handleError(error: nil)
    }
}
