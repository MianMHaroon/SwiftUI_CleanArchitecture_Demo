//
//  FavoritesLocalDataSource.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 20/06/2026.
//

import Foundation

protocol FavoritesLocalDataSourceProtocol: Sendable {
    func loadFavorites() throws -> [RepositoryEntity]
    func saveFavorites(_ favorites: [RepositoryEntity]) throws
    func clearFavorites() throws
}

final class FavoritesLocalDataSource: FavoritesLocalDataSourceProtocol, @unchecked Sendable {

    // MARK: - Properties

    private let store: UserDefaultsStoreProtocol
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    // MARK: - Lifecycle

    init(store: UserDefaultsStoreProtocol) {
        self.store = store
    }

    // MARK: - Public Methods

    func loadFavorites() throws -> [RepositoryEntity] {
        guard let data = store.data(for: .favorites) else {
            return []
        }
        return try decoder.decode([RepositoryEntity].self, from: data)
    }

    func saveFavorites(_ favorites: [RepositoryEntity]) throws {
        let data = try encoder.encode(favorites)
        store.set(data, for: .favorites)
    }

    func clearFavorites() throws {
        store.removeValue(for: .favorites)
    }
}
