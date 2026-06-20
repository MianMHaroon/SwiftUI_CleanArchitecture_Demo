//
//  SwiftUI_CleanArchitecture_DemoApp.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Combine
import SwiftUI

@main
struct SwiftUI_CleanArchitecture_DemoApp: App {

    // MARK: - Properties

    @StateObject private var appState: AppState
    @StateObject private var coordinator: AppCoordinator
    @StateObject private var networkMonitor = NetworkMonitor()

    // MARK: - Lifecycle

    init() {
        let state = AppState()
        _appState = StateObject(wrappedValue: state)
        _coordinator = StateObject(wrappedValue: AppCoordinator(appState: state))
    }

    // MARK: - Body

    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environmentObject(appState)
                .environmentObject(coordinator)
                .background(AppColors.appBackground)
                .onReceive(networkMonitor.$isConnected) { [weak appState] isConnected in
                    appState?.updateNetworkAvailability(isConnected)
                }
                .progressOverlay(
                    isLoading: $appState.isLoading,
                    message: NSLocalizedString("loading.global", comment: "")
                )
                .overlay(alignment: .bottom) {
                    if let toastMessage = appState.toastMessage {
                        ToastBannerView(message: toastMessage) {
                            appState.dismissToast()
                        }
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .padding(.bottom, DesignTokens.Spacing.lg)
                        .accessibilityIdentifier("toast_banner")
                    }
                }
                .alert(
                    NSLocalizedString("error.title", comment: ""),
                    isPresented: Binding(
                        get: { appState.presentedError != nil },
                        set: { if !$0 { appState.dismissError() } }
                    )
                ) {
                    Button(NSLocalizedString("action.ok", comment: ""), role: .cancel) {
                        appState.dismissError()
                    }
                } message: {
                    Text(appState.presentedError ?? "")
                }
        }
    }
}
