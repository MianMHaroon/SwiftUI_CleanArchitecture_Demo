//
//  SearchRepositoriesUseCase.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Foundation

protocol SearchRepositoriesUseCaseProtocol: Sendable {
    func execute(query: String) async throws -> [RepositoryEntity]
}

final class SearchRepositoriesUseCase: SearchRepositoriesUseCaseProtocol, @unchecked Sendable {

    // MARK: - Properties

    private let repository: GitHubRepositoryInterface

    // MARK: - Lifecycle

    init(repository: GitHubRepositoryInterface) {
        self.repository = repository
    }

    // MARK: - Public Methods

    func execute(query: String) async throws -> [RepositoryEntity] {
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedQuery.isEmpty else {
            return []
        }
        return try await repository.searchRepositories(query: trimmedQuery)
    }
}
