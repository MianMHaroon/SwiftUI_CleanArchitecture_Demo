//
//  SaveFavoriteRepositoryUseCase.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Foundation

protocol SaveFavoriteRepositoryUseCaseProtocol: Sendable {
    func execute(repository: RepositoryEntity) async throws
}

final class SaveFavoriteRepositoryUseCase: SaveFavoriteRepositoryUseCaseProtocol, @unchecked Sendable {

    // MARK: - Properties

    private let repository: FavoritesRepositoryInterface

    // MARK: - Lifecycle

    init(repository: FavoritesRepositoryInterface) {
        self.repository = repository
    }

    // MARK: - Public Methods

    func execute(repository: RepositoryEntity) async throws {
        try await self.repository.saveFavorite(repository)
    }
}
