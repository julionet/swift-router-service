//
//  {Feature}ViewModelNotificationSpy.swift
//  {Module}
//
//  Created by {Author} on {Date}.
//

@testable import {Module}
import PanPaymentGatewayInterface

// TODO: adicionar/remover flags conforme os métodos reais de {Feature}ViewModelNotification
final class {Feature}ViewModelNotificationSpy: {Feature}ViewModelNotification {

    private(set) var didUpdateCalled = false
    private(set) var handleErrorCalled = false

    // Handlers opcionais para sincronizar com expectations em testes assíncronos
    var didUpdateHandler: (() -> Void)?
    var handleErrorHandler: ((PaymentAnalyticsErrorModel?) -> Void)?

    func didUpdate() {
        didUpdateCalled = true
        didUpdateHandler?()
    }

    func handleError(error: PaymentAnalyticsErrorModel?) {
        handleErrorCalled = true
        handleErrorHandler?(error)
    }
}
