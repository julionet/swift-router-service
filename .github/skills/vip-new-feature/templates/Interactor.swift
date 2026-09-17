//
//  {Feature}Interactor.swift
//  App
//
//  Created by {Author} on {Date}.
//

import Foundation

protocol {Feature}BusinessLogic {
    func loadScreenValues()
}

protocol {Feature}DataStore {
    // TODO: declare aqui as propriedades que precisam ser compartilhadas com outras cenas
}

final class {Feature}Interactor: {Feature}BusinessLogic, {Feature}DataStore {
    
    // MARK: - Archtecture Objects
    
    var presenter: {Feature}PresentationLogic?
    let worker: {Feature}WorkerLogic
    
    // MARK: - DataStore Objects
    
    // TODO: declare aqui as propriedades do DataStore
    
    // MARK: - Interactor Lifecycle
    
    init(worker: {Feature}WorkerLogic = {Feature}Worker()) {
        self.worker = worker
    }
    
    // MARK: - Business Logic
    
    func loadScreenValues() {
        // TODO: implementar a regra de negócio da tela
        presenter?.presentScreenValues()
    }
}
