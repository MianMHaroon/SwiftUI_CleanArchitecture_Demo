//
//  TrendingViewModel.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Combine
import FactoryKit
import Foundation

@MainActor
final class TrendingViewModel: BaseViewModel {

    // MARK: - Properties

    @Injected(\.getTrendingRepositoriesUseCase) private var getTrendingRepositoriesUseCase

    @Published private(set) var topics = TrendingTopic.allCases
    @Published private(set) var repositoriesByTopic: [TrendingTopic: [RepositoryEntity]] = [:]
    @Published private(set) var loadingTopics: Set<TrendingTopic> = []
    @Published private(set) var errorMessage: String?

    var isLoadingAnyTopic: Bool {
        !loadingTopics.isEmpty
    }

    // MARK: - Public Methods

    func loadRepositories(for topic: TrendingTopic) async {
        loadingTopics.insert(topic)
        defer { loadingTopics.remove(topic) }

        do {
            let repositories = try await getTrendingRepositoriesUseCase.execute(topic: topic)
            repositoriesByTopic[topic] = Array(repositories.prefix(5))
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func loadAllTopics() async {
        for topic in topics {
            await loadRepositories(for: topic)
        }
    }

    func repositories(for topic: TrendingTopic) -> [RepositoryEntity] {
        repositoriesByTopic[topic] ?? []
    }

    func isLoading(_ topic: TrendingTopic) -> Bool {
        loadingTopics.contains(topic)
    }
}
