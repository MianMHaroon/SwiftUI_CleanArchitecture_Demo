//
//  FavoritesView.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Combine
import FactoryKit
import SwiftUI

struct FavoritesView: View {

    // MARK: - Properties

    @InjectedObject(\.favoritesViewModel) private var viewModel
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var coordinator: AppCoordinator

    // MARK: - Body

    var body: some View {
        NavigationStack(path: $coordinator.favoritesPath) {
            content
                .background(AppColors.appBackground)
                .navigationTitle(NSLocalizedString("favorites.title", comment: ""))
                .navigationDestination(for: AppRoute.self) { route in
                    NavigationDestinationBuilder.destination(for: route)
                }
                .bindAppState(to: viewModel, appState: appState)
                .progressOverlay(
                    isLoading: Binding(
                        get: { viewModel.state.isLoading },
                        set: { _ in }
                    ),
                    message: NSLocalizedString("favorites.loading", comment: "")
                )
                .task {
                    await viewModel.loadFavorites()
                }
                .refreshable {
                    await viewModel.loadFavorites()
                }
        }
        .accessibilityIdentifier("favorites_view")
    }

    // MARK: - Private Methods

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            Color.clear

        case .empty:
            EmptyStateView(
                title: NSLocalizedString("favorites.empty.title", comment: ""),
                message: NSLocalizedString("favorites.empty.message", comment: ""),
                systemImage: "star"
            )

        case .error(let message):
            ErrorView(message: message) {
                Task { await viewModel.loadFavorites() }
            }

        case .loaded(let favorites):
            List(favorites) { repository in
                Button {
                    coordinator.openRepositoryDetail(repository, from: .favorites)
                } label: {
                    RepositoryCardView(repository: repository)
                }
                .buttonStyle(.plain)
                .swipeActions {
                    Button(role: .destructive) {
                        Task { await viewModel.removeFavorite(id: repository.id) }
                    } label: {
                        Label(NSLocalizedString("action.remove", comment: ""), systemImage: "trash")
                    }
                }
                .listRowSeparator(.hidden)
                .listRowBackground(AppColors.appBackground)
                .listRowInsets(EdgeInsets(
                    top: DesignTokens.Spacing.xs,
                    leading: DesignTokens.Spacing.md,
                    bottom: DesignTokens.Spacing.xs,
                    trailing: DesignTokens.Spacing.md
                ))
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
    }
}

#Preview {
    FavoritesView()
        .environmentObject(AppState())
        .environmentObject(AppCoordinator(appState: AppState()))
}
