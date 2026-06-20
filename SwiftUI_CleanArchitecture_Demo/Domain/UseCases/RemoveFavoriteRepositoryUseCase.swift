//
//  RemoveFavoriteRepositoryUseCase.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Foundation

protocol RemoveFavoriteRepositoryUseCaseProtocol: Sendable {
    func execute(repositoryID: Int) async throws
}

final class RemoveFavoriteRepositoryUseCase: RemoveFavoriteRepositoryUseCaseProtocol, @unchecked Sendable {

    // MARK: - Properties

    private let repository: FavoritesRepositoryInterface

    // MARK: - Lifecycle

    init(repository: FavoritesRepositoryInterface) {
        self.repository = repository
    }

    // MARK: - Public Methods

    func execute(repositoryID: Int) async throws {
        try await repository.removeFavorite(id: repositoryID)
    }
}
