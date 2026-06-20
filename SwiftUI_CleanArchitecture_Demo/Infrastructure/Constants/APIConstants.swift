//
//  APIConstants.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Foundation

enum APIConstants {
    static let baseURL = URL(string: "https://api.github.com")!
    static let acceptHeader = "application/vnd.github+json"
    static let userAgent = "SwiftUI_CleanArchitecture_Demo"
    static let documentationURL = URL(string: "https://docs.github.com/en/rest")!
}
