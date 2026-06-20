//
//  RootTabView.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Combine
import SwiftUI

struct RootTabView: View {

    // MARK: - Properties

    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var coordinator: AppCoordinator

    // MARK: - Body

    var body: some View {
        TabView(selection: $appState.selectedTab) {
            DiscoverTabView()
                .tabItem {
                    Label(AppTab.discover.title, systemImage: AppTab.discover.systemImage)
                }
                .tag(AppTab.discover)
                .accessibilityIdentifier("tab_discover")

            FavoritesView()
                .tabItem {
                    Label(AppTab.favorites.title, systemImage: AppTab.favorites.systemImage)
                }
                .tag(AppTab.favorites)
                .accessibilityIdentifier("tab_favorites")

            TrendingView()
                .tabItem {
                    Label(AppTab.trending.title, systemImage: AppTab.trending.systemImage)
                }
                .tag(AppTab.trending)
                .accessibilityIdentifier("tab_trending")

            SettingsView()
                .tabItem {
                    Label(AppTab.settings.title, systemImage: AppTab.settings.systemImage)
                }
                .tag(AppTab.settings)
                .accessibilityIdentifier("tab_settings")
        }
        .tint(AppColors.accent)
        .overlay(alignment: .top) {
            if !coordinator.isNetworkAvailable {
                Text(NSLocalizedString("error.network_unavailable", comment: ""))
                    .font(AppTypography.caption)
                    .foregroundStyle(AppColors.onAccent)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, DesignTokens.Spacing.xs)
                    .background(AppColors.destructive)
                    .accessibilityIdentifier("network_offline_banner")
            }
        }
        .sheet(item: $coordinator.presentedSheet) { route in
            switch route {
            case .settingsInfo:
                NavigationStack {
                    Text(NSLocalizedString("settings.info.placeholder", comment: ""))
                        .foregroundStyle(AppColors.primaryText)
                        .navigationTitle(NSLocalizedString("settings.info.title", comment: ""))
                }
            }
        }
        .fullScreenCover(item: $coordinator.presentedFullScreen) { route in
            switch route {
            case .onboardingPlaceholder:
                Text(NSLocalizedString("onboarding.placeholder", comment: ""))
                    .foregroundStyle(AppColors.primaryText)
            }
        }
    }
}

#Preview {
    RootTabView()
        .environmentObject(AppState())
        .environmentObject(AppCoordinator(appState: AppState()))
}
