//
//  AppCoordinator.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Combine
import SwiftUI

@MainActor
final class AppCoordinator: ObservableObject {

    // MARK: - Properties

    @Published var discoverPath = NavigationPath()
    @Published var favoritesPath = NavigationPath()
    @Published var trendingPath = NavigationPath()
    @Published var settingsPath = NavigationPath()

    @Published var presentedSheet: SheetRoute?
    @Published var presentedFullScreen: FullScreenRoute?
    @Published private(set) var selectedTab: AppTab = .discover
    @Published private(set) var isNetworkAvailable = true

    private var appState: AppState?
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Lifecycle

    init(appState: AppState) {
        bind(appState: appState)
    }

    // MARK: - Public Methods

    func bind(appState: AppState) {
        cancellables.removeAll()
        self.appState = appState
        observe(appState)
    }

    func selectTab(_ tab: AppTab) {
        appState?.selectedTab = tab
    }

    func push(_ route: AppRoute, on tab: AppTab) {
        switch tab {
        case .discover:
            discoverPath.append(route)
        case .favorites:
            favoritesPath.append(route)
        case .trending:
            trendingPath.append(route)
        case .settings:
            settingsPath.append(route)
        }
    }

    func popToRoot(on tab: AppTab) {
        switch tab {
        case .discover:
            discoverPath = NavigationPath()
        case .favorites:
            favoritesPath = NavigationPath()
        case .trending:
            trendingPath = NavigationPath()
        case .settings:
            settingsPath = NavigationPath()
        }
    }

    func presentSheet(_ route: SheetRoute) {
        presentedSheet = route
    }

    func dismissSheet() {
        presentedSheet = nil
    }

    func presentFullScreen(_ route: FullScreenRoute) {
        presentedFullScreen = route
    }

    func dismissFullScreen() {
        presentedFullScreen = nil
    }

    func openRepositoryDetail(_ repository: RepositoryEntity, from tab: AppTab) {
        push(.repositoryDetail(repository), on: tab)
    }

    func openOwnerDetail(_ owner: OwnerEntity, from tab: AppTab) {
        push(.ownerDetail(owner), on: tab)
    }

    func handleDeepLink(repositoryID: Int) {
        selectTab(.discover)
        appState?.showToast(NSLocalizedString("deeplink.placeholder", comment: ""))
    }

    // MARK: - Private Methods

    private func observe(_ appState: AppState) {
        selectedTab = appState.selectedTab
        isNetworkAvailable = appState.isNetworkAvailable

        appState.$selectedTab
            .receive(on: DispatchQueue.main)
            .sink { [weak self] tab in
                self?.selectedTab = tab
            }
            .store(in: &cancellables)

        appState.$isNetworkAvailable
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isAvailable in
                self?.isNetworkAvailable = isAvailable
            }
            .store(in: &cancellables)

        appState.$presentedError
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.dismissSheet()
            }
            .store(in: &cancellables)
    }
}
