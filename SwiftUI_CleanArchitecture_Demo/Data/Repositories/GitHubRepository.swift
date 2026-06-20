//
//  GitHubRepository.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Foundation

final class GitHubRepository: GitHubRepositoryInterface, @unchecked Sendable {

    // MARK: - Properties

    private let remoteDataSource: GitHubRemoteDataSourceProtocol

    // MARK: - Lifecycle

    init(remoteDataSource: GitHubRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }

    // MARK: - Public Methods

    func searchRepositories(query: String) async throws -> [RepositoryEntity] {
        let dtos = try await remoteDataSource.searchRepositories(query: query)
        return RepositoryMapper.map(dtos)
    }
}
