//
//  InfoKeys.swift
//  SwiftApp
//
//  Created by Jose Julio Junior on 15/09/26.
//

import Foundation

enum InfoKeys {

    enum Localized: String, Localizable {
        case title
        // TODO: adicionar as demais chaves usadas em Info.strings

        var tableName: String { "Info" }
    }
}
