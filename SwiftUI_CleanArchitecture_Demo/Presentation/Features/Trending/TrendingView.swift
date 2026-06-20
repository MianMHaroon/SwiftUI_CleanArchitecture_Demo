//
//  TrendingView.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Combine
import FactoryKit
import SwiftUI

struct TrendingView: View {
    
    // MARK: - Properties
    
    @InjectedObject(\.trendingViewModel) private var viewModel
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var coordinator: AppCoordinator
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack(path: $coordinator.trendingPath) {
            ScrollView {
                LazyVStack(spacing: DesignTokens.Spacing.lg) {
                    ForEach(viewModel.topics) { topic in
                        trendingSection(for: topic)
                    }
                }
                .padding(DesignTokens.Spacing.md)
            }
            .background(AppColors.appBackground)
            .navigationTitle(NSLocalizedString("trending.title", comment: ""))
            .navigationDestination(for: AppRoute.self) { route in
                NavigationDestinationBuilder.destination(for: route)
            }
            .bindAppState(to: viewModel, appState: appState)
            .progressOverlay(
                isLoading: Binding(
                    get: { viewModel.isLoadingAnyTopic },
                    set: { _ in }
                ),
                message: NSLocalizedString("loading.global", comment: "")
            )
            .task {
                await viewModel.loadAllTopics()
            }
            .refreshable {
                await viewModel.loadAllTopics()
            }
        }
        .accessibilityIdentifier("trending_view")
    }
    
    // MARK: - Private Methods
    
    @ViewBuilder
    private func trendingSection(for topic: TrendingTopic) -> some View {
        VStack(alignment: .leading, spacing: DesignTokens.Spacing.sm) {
            if !viewModel.repositoriesByTopic.isEmpty {
                Text(topic.rawValue)
                    .font(AppTypography.headline)
                    .foregroundStyle(AppColors.primaryText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .accessibilityIdentifier("trending_topic_\(topic.rawValue)")
            }
            
            if let errorMessage = viewModel.errorMessage, viewModel.repositories(for: topic).isEmpty {
                Text(errorMessage)
                    .font(AppTypography.caption)
                    .foregroundStyle(AppColors.secondaryText)
            } else {
                ForEach(viewModel.repositories(for: topic)) { repository in
                    Button {
                        coordinator.openRepositoryDetail(repository, from: .trending)
                    } label: {
                        RepositoryCardView(repository: repository)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

#Preview {
    TrendingView()
        .environmentObject(AppState())
        .environmentObject(AppCoordinator(appState: AppState()))
}
