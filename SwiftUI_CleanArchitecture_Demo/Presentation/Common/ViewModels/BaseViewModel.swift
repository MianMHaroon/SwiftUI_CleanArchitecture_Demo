//
//  BaseViewModel.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Combine
import SwiftUI


@MainActor
class BaseViewModel: ObservableObject {

    // MARK: - Properties

    weak var appState: AppState?

    // MARK: - Public Methods

    func setAppState(_ appState: AppState) {
        self.appState = appState
    }

    func handleLoadingIndicator(value: Bool) {
        appState?.setLoading(value)
    }

    func showError(_ error: Error) {
        appState?.showError(error)
    }

    func showErrorMessage(_ message: String) {
        appState?.showErrorMessage(message)
    }

    func showToast(_ message: String) {
        appState?.showToast(message)
    }
}
