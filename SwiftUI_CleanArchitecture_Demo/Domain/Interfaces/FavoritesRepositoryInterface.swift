//
//  FavoritesRepositoryInterface.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Foundation

protocol FavoritesRepositoryInterface: Sendable {
    func getFavorites() async throws -> [RepositoryEntity]
    func saveFavorite(_ repository: RepositoryEntity) async throws
    func removeFavorite(id: Int) async throws
    func clearCache() async throws
}
