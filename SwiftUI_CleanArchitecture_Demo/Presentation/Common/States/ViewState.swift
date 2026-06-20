//
//  ViewState.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Foundation

enum ViewState<T: Equatable>: Equatable {
    case idle
    case loading
    case loaded(T)
    case empty
    case error(String)

    var isLoading: Bool {
        if case .loading = self { return true }
        return false
    }
}
