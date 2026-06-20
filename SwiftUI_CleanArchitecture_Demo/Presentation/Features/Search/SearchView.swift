//
//  SearchView.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Combine
import SwiftUI

struct SearchView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: SearchViewModel
    @EnvironmentObject private var coordinator: AppCoordinator
    @EnvironmentObject private var appState: AppState

    // MARK: - Body

    var body: some View {
        VStack(spacing: DesignTokens.Spacing.md) {
            SearchBarView(
                text: $viewModel.query,
                placeholder: NSLocalizedString("search.placeholder", comment: ""),
                onSubmit: {
                    Task { await viewModel.search(isNetworkAvailable: appState.isNetworkAvailable) }
                }
            )
            .padding(.horizontal, DesignTokens.Spacing.md)

            content
        }
        .background(AppColors.appBackground)
        .navigationTitle(NSLocalizedString("discover.title", comment: ""))
        .bindAppState(to: viewModel, appState: appState)
        .progressOverlay(
            isLoading: Binding(
                get: { viewModel.state.isLoading },
                set: { _ in }
            ),
            message: NSLocalizedString("search.loading", comment: "")
        )
        .accessibilityIdentifier("search_view")
    }

    // MARK: - Private Methods

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle:
            EmptyStateView(
                title: NSLocalizedString("search.idle.title", comment: ""),
                message: NSLocalizedString("search.idle.message", comment: ""),
                systemImage: "magnifyingglass"
            )
            .frame(maxHeight: .infinity)

        case .loading:
            Color.clear
                .frame(maxHeight: .infinity)

        case .empty:
            EmptyStateView(
                title: NSLocalizedString("search.empty.title", comment: ""),
                message: NSLocalizedString("search.empty.message", comment: ""),
                systemImage: "tray"
            )
            .frame(maxHeight: .infinity)

        case .error(let message):
            ErrorView(message: message) {
                Task { await viewModel.search(isNetworkAvailable: appState.isNetworkAvailable) }
            }
            .frame(maxHeight: .infinity)

        case .loaded(let repositories):
            ScrollView {
                LazyVStack(spacing: DesignTokens.Spacing.sm) { 
                    ForEach(repositories) { repository in
                        Button {
                            coordinator.openRepositoryDetail(repository, from: .discover)
                        } label: {
                            RepositoryCardView(repository: repository)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, DesignTokens.Spacing.md)
                .padding(.vertical, DesignTokens.Spacing.xs)
            }
            .background(AppColors.appBackground)
        }
    }
}

#Preview {
    NavigationStack {
        SearchView(viewModel: SearchViewModel())
            .environmentObject(AppCoordinator(appState: AppState()))
            .environmentObject(AppState())
    }
}
