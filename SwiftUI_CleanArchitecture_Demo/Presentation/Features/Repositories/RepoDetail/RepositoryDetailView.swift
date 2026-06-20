//
//  RepositoryDetailView.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Combine
import SwiftUI

struct RepositoryDetailView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: RepositoryDetailViewModel
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var coordinator: AppCoordinator

    // MARK: - Body

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: DesignTokens.Spacing.lg) {
                Text(viewModel.repository.name)
                    .font(AppTypography.largeTitle)
                    .foregroundStyle(AppColors.primaryText)
                    .accessibilityIdentifier("repository_detail_name")

                if let description = viewModel.repository.description {
                    Text(description)
                        .font(AppTypography.body)
                        .foregroundStyle(AppColors.secondaryText)
                }

                statsSection
                ownerSection
            }
            .padding(DesignTokens.Spacing.md)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        }
        .background(AppColors.appBackground)
        .navigationTitle(viewModel.repository.fullName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    Task { await viewModel.toggleFavorite() }
                } label: {
                    Image(systemName: viewModel.isFavorite ? "star.fill" : "star")
                        .foregroundStyle(AppColors.accent)
                }
                .disabled(viewModel.isSavingFavorite)
                .accessibilityIdentifier("repository_favorite_button")
            }
        }
        .bindAppState(to: viewModel, appState: appState)
        .progressOverlay(
            isLoading: Binding(
                get: { viewModel.isSavingFavorite },
                set: { _ in }
            )
        )
        .task {
            await viewModel.onAppear()
        }
        .accessibilityIdentifier("repository_detail_view")
    }

    // MARK: - Private Methods

    private var statsSection: some View {
        VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
            Text(NSLocalizedString("repository.stats.title", comment: ""))
                .font(AppTypography.headline)
                .foregroundStyle(AppColors.primaryText)

            Label("\(viewModel.repository.stars)", systemImage: "star.fill")
            Label("\(viewModel.repository.forks)", systemImage: "tuningfork")
            if let language = viewModel.repository.language {
                Label(language, systemImage: "chevron.left.forwardslash.chevron.right")
            }
        }
        .foregroundStyle(AppColors.secondaryText)
    }

    private var ownerSection: some View {
        VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
            Text(NSLocalizedString("repository.owner.title", comment: ""))
                .font(AppTypography.headline)
                .foregroundStyle(AppColors.primaryText)

            Button {
                coordinator.openOwnerDetail(viewModel.repository.owner, from: appState.selectedTab)
            } label: {
                HStack(spacing: DesignTokens.Spacing.sm) {
                    AsyncImage(url: viewModel.repository.owner.avatarURL) { image in
                        image.resizable().scaledToFill()
                    } placeholder: {
                        AppColors.placeholder
                    }
                    .frame(width: DesignTokens.IconSize.avatar, height: DesignTokens.IconSize.avatar)
                    .clipShape(Circle())

                    Text(viewModel.repository.owner.login)
                        .font(AppTypography.headline)
                        .foregroundStyle(AppColors.primaryText)
                }
            }
            .buttonStyle(.plain)
            .accessibilityIdentifier("repository_owner_button")
        }
    }
}

#Preview {
    NavigationStack {
        RepositoryDetailView(
            viewModel: RepositoryDetailViewModel(
                repository: RepositoryEntity(
                    id: 1,
                    name: "swift",
                    fullName: "apple/swift",
                    description: "The Swift Programming Language",
                    stars: 68000,
                    forks: 10500,
                    language: "Swift",
                    htmlURL: URL(string: "https://github.com/apple/swift")!,
                    owner: OwnerEntity(
                        id: 1,
                        login: "apple",
                        avatarURL: URL(string: "https://github.com/apple.png")!,
                        htmlURL: URL(string: "https://github.com/apple")!
                    )
                )
            )
        )
        .environmentObject(AppState())
        .environmentObject(AppCoordinator(appState: AppState()))
    }
}
