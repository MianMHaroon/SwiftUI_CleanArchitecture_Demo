//
//  String+Localization.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Foundation

extension String {
    static func localized(_ key: String, comment: String = "") -> String {
        NSLocalizedString(key, comment: comment)
    }
}
