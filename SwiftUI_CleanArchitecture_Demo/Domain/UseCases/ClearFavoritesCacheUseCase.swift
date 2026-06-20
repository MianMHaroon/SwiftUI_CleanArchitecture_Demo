//
//  ClearFavoritesCacheUseCase.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Foundation

protocol ClearFavoritesCacheUseCaseProtocol: Sendable {
    func execute() async throws
}

final class ClearFavoritesCacheUseCase: ClearFavoritesCacheUseCaseProtocol, @unchecked Sendable {

    // MARK: - Properties

    private let repository: FavoritesRepositoryInterface

    // MARK: - Lifecycle

    init(repository: FavoritesRepositoryInterface) {
        self.repository = repository
    }

    // MARK: - Public Methods

    func execute() async throws {
        try await repository.clearCache()
    }
}
