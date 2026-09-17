//
//  {Feature}Presenter.swift
//  App
//
//  Created by {Author} on {Date}.
//

import Foundation

protocol {Feature}PresentationLogic {
    func presentScreenValues()
}

final class {Feature}Presenter: {Feature}PresentationLogic {
    
    // MARK: - Archtecture Objects
    
    weak var viewController: {Feature}DisplayLogic?
    private typealias Localized = {Feature}Keys.Localized
    
    // MARK: - Presentation Logic
    
    func presentScreenValues() {
        // TODO: montar o ViewModel a partir da resposta do Interactor
        let viewModel = {Feature}.Model.ViewModel()
        viewController?.displayScreenValues(viewModel: viewModel)
    }
}
