//
//  InitKeys.swift
//  SwiftApp
//
//  Created by Jose Julio Junior on 15/09/26.
//

import Foundation

enum InitKeys {

    enum Localized: String, Localizable {
        case title
        case buttonText
        // TODO: adicionar as demais chaves usadas em Init.strings

        var tableName: String { "Init" }
    }
}
