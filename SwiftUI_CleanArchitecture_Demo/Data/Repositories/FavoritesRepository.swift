//
//  FavoritesRepository.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Foundation

final class FavoritesRepository: FavoritesRepositoryInterface, @unchecked Sendable {

    // MARK: - Properties

    private let localDataSource: FavoritesLocalDataSourceProtocol

    // MARK: - Lifecycle

    init(localDataSource: FavoritesLocalDataSourceProtocol) {
        self.localDataSource = localDataSource
    }

    // MARK: - Public Methods

    func getFavorites() async throws -> [RepositoryEntity] {
        try localDataSource.loadFavorites()
    }

    func saveFavorite(_ repository: RepositoryEntity) async throws {
        var favorites = try await getFavorites()
        guard !favorites.contains(where: { $0.id == repository.id }) else {
            return
        }
        favorites.append(repository)
        try localDataSource.saveFavorites(favorites)
    }

    func removeFavorite(id: Int) async throws {
        var favorites = try await getFavorites()
        favorites.removeAll { $0.id == id }
        try localDataSource.saveFavorites(favorites)
    }

    func clearCache() async throws {
        try localDataSource.clearFavorites()
    }
}
