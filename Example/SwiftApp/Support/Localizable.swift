//
//  Localizable.swift
//  SwiftApp
//
//  Created by Jose Julio Junior on 15/09/26.
//

import Foundation

protocol Localizable {
    var tableName: String { get }
}

extension Localizable where Self: RawRepresentable, Self.RawValue == String {
    var localized: String {
        NSLocalizedString(rawValue, tableName: tableName, bundle: .main, comment: "")
    }
}
