//
//  GetTrendingRepositoriesUseCase.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Foundation

protocol GetTrendingRepositoriesUseCaseProtocol: Sendable {
    func execute(topic: TrendingTopic) async throws -> [RepositoryEntity]
}

enum TrendingTopic: String, CaseIterable, Identifiable, Sendable {
    case swift = "Swift"
    case swiftUI = "SwiftUI"
    case ai = "AI"
    case iOS = "iOS"

    var id: String { rawValue }

    var searchQuery: String { rawValue }
}

final class GetTrendingRepositoriesUseCase: GetTrendingRepositoriesUseCaseProtocol, @unchecked Sendable {

    // MARK: - Properties

    private let repository: GitHubRepositoryInterface

    // MARK: - Lifecycle

    init(repository: GitHubRepositoryInterface) {
        self.repository = repository
    }

    // MARK: - Public Methods

    func execute(topic: TrendingTopic) async throws -> [RepositoryEntity] {
        try await repository.searchRepositories(query: topic.searchQuery)
    }
}
