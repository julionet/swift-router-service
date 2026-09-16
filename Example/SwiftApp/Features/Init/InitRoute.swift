//
//  InitRoute.swift
//  SwiftApp
//
//  Created by Jose Julio Junior on 15/09/26.
//

import Foundation
import SwiftRouterService

struct InitRoute: Route {
    static let identifier: String = String(describing: Self.self)

    let dataStore: InitDataStore

    init(dataStore: InitDataStore) {
        self.dataStore = dataStore
    }
}
