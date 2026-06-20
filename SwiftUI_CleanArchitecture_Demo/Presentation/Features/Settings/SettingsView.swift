//
//  SettingsView.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Combine
import FactoryKit
import SwiftUI

struct SettingsView: View {

    // MARK: - Properties

    @InjectedObject(\.settingsViewModel) private var viewModel
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var coordinator: AppCoordinator

    // MARK: - Body

    var body: some View {
        NavigationStack(path: $coordinator.settingsPath) {
            List {
                Section(NSLocalizedString("settings.section.app", comment: "")) {
                    HStack {
                        Text(NSLocalizedString("settings.version", comment: ""))
                        Spacer()
                        Text(viewModel.appVersion)
                            .foregroundStyle(AppColors.secondaryText)
                    }
                    .accessibilityIdentifier("settings_version_row")

                    HStack {
                        Text(NSLocalizedString("settings.network", comment: ""))
                        Spacer()
                        Text(
                            appState.isNetworkAvailable
                                ? NSLocalizedString("settings.network.online", comment: "")
                                : NSLocalizedString("settings.network.offline", comment: "")
                        )
                        .foregroundStyle(appState.isNetworkAvailable ? AppColors.success : AppColors.destructive)
                    }
                }

                Section(NSLocalizedString("settings.section.actions", comment: "")) {
                    Button(NSLocalizedString("settings.clear_cache", comment: "")) {
                        Task { await viewModel.clearCache() }
                    }
                    .accessibilityIdentifier("settings_clear_cache_button")

                    Link(
                        NSLocalizedString("settings.api_docs", comment: ""),
                        destination: viewModel.documentationURL
                    )
                    .accessibilityIdentifier("settings_api_docs_link")
                }

                Section(NSLocalizedString("settings.section.appearance", comment: "")) {
                    HStack {
                        Text(NSLocalizedString("settings.theme", comment: ""))
                        Spacer()
                        Text(NSLocalizedString("settings.theme.placeholder", comment: ""))
                            .foregroundStyle(AppColors.secondaryText)
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(AppColors.appBackground)
            .navigationTitle(NSLocalizedString("settings.title", comment: ""))
            .bindAppState(to: viewModel, appState: appState)
        }
        .accessibilityIdentifier("settings_view")
    }
}

#Preview {
    SettingsView()
        .environmentObject(AppState())
        .environmentObject(AppCoordinator(appState: AppState()))
}
