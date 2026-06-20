//
//  GetFavoritesUseCase.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Foundation

protocol GetFavoritesUseCaseProtocol: Sendable {
    func execute() async throws -> [RepositoryEntity]
}

final class GetFavoritesUseCase: GetFavoritesUseCaseProtocol, @unchecked Sendable {

    // MARK: - Properties

    private let repository: FavoritesRepositoryInterface

    // MARK: - Lifecycle

    init(repository: FavoritesRepositoryInterface) {
        self.repository = repository
    }

    // MARK: - Public Methods

    func execute() async throws -> [RepositoryEntity] {
        try await repository.getFavorites()
    }
}
