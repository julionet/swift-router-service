//
//  {Feature}Router.swift
//  App
//
//  Created by {Author} on {Date}.
//

import Foundation

protocol {Feature}RoutingLogic {
    
}

protocol {Feature}DataPassing {
    var dataStore: {Feature}DataStore? { get }
}

final class {Feature}Router: NSObject, {Feature}RoutingLogic, {Feature}DataPassing {
    
    // MARK: - Archtecture Objects
    
    weak var viewController: {Feature}ViewController?
    var dataStore: {Feature}DataStore?
    
    // MARK: - Routing Logic
    
    // TODO: implemente os métodos de navegação entre cenas, se necessário
    
    // MARK: - Passing data
    
    // TODO: implemente os métodos de passagem de dados entre cenas, se necessário
    // private func passDataTo{Destination}(source: {Feature}DataStore?, destination: inout {Destination}DataStore?) {
    //     destination?.someProperty = source?.someProperty
    // }
}
