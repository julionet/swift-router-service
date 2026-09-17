//
//  {Feature}Route.swift
//  SwiftRouterService
//
//  Created by {Author} on {Date}.
//

import Foundation
import PanRouterServiceInterface

public struct {Feature}Route: Route {
    public static let identifier: String = String(describing: Self.self)

    public let dataStore: {Feature}DataStore

    public init(dataStore: {Feature}DataStore) {
        self.dataStore = dataStore
    }
}
