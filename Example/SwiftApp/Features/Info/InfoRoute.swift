//
//  InfoRoute.swift
//  SwiftApp
//
//  Created by Jose Julio Junior on 15/09/26.
//

import Foundation
import SwiftRouterService

struct InfoRoute: Route {
    static let identifier: String = String(describing: Self.self)

    let dataStore: InfoDataStore

    init(dataStore: InfoDataStore) {
        self.dataStore = dataStore
    }
}
