//
//  GitHubRemoteDataSource.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Foundation

protocol GitHubRemoteDataSourceProtocol: Sendable {
    func searchRepositories(query: String) async throws -> [RepositoryDTO]
}

final class GitHubRemoteDataSource: GitHubRemoteDataSourceProtocol, @unchecked Sendable {

    // MARK: - Properties

    private let apiClient: APIClientProtocol

    // MARK: - Lifecycle

    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }

    // MARK: - Public Methods

    func searchRepositories(query: String) async throws -> [RepositoryDTO] {
        let endpoint = APIEndpoint(
            path: "search/repositories",
            queryItems: [URLQueryItem(name: "q", value: query)]
        )
        let response: SearchRepositoriesResponseDTO = try await apiClient.request(endpoint)
        return response.items
    }
}
