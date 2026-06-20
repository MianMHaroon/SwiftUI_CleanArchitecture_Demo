//
//  SettingsViewModel.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Combine
import FactoryKit
import Foundation

@MainActor
final class SettingsViewModel: BaseViewModel {

    // MARK: - Properties

    @Injected(\.clearFavoritesCacheUseCase) private var clearFavoritesCacheUseCase

    var appVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
        return "\(version) (\(build))"
    }

    let documentationURL = APIConstants.documentationURL

    // MARK: - Public Methods

    func clearCache() async {
        handleLoadingIndicator(value: true)
        defer { handleLoadingIndicator(value: false) }

        do {
            try await clearFavoritesCacheUseCase.execute()
            showToast(NSLocalizedString("settings.cache_cleared", comment: ""))
        } catch {
            showError(error)
        }
    }
}
