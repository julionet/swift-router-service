//
//  {Feature}ViewModelServiceSpy.swift
//  {Module}
//
//  Created by {Author} on {Date}.
//

@testable import {Module}

// Usado nos testes do {Feature}ViewController, no lugar do {Feature}ViewModel real.
// TODO: adicionar/remover flags conforme os métodos reais de {Feature}ViewModelService
final class {Feature}ViewModelServiceSpy: {Feature}ViewModelService {

    private(set) var fetchValuesCalled = false

    var sceneModel: {Feature}Model.SceneModel?
    var dataStore: {Feature}DataStore?

    func fetchValues() {
        fetchValuesCalled = true
    }
}
