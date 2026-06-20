//
//  AppState.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Combine
import SwiftUI

@MainActor
final class AppState: ObservableObject {

    // MARK: - Properties

    @Published var isLoading = false
    @Published var toastMessage: String?
    @Published var presentedError: String?
    @Published var isNetworkAvailable = true
    @Published var selectedTab: AppTab = .discover

    // MARK: - Public Methods

    func setLoading(_ isLoading: Bool) {
        self.isLoading = isLoading
    }

    func showToast(_ message: String) {
        toastMessage = message
    }

    func dismissToast() {
        toastMessage = nil
    }

    func showError(_ error: Error) {
        if let apiError = error as? APIError {
            presentedError = apiError.errorDescription
        } else {
            presentedError = error.localizedDescription
        }
    }

    func showErrorMessage(_ message: String) {
        presentedError = message
    }

    func dismissError() {
        presentedError = nil
    }

    func updateNetworkAvailability(_ isAvailable: Bool) {
        isNetworkAvailable = isAvailable
    }
}
