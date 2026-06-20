//
//  RepositoryDetailViewModel.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Combine
import FactoryKit
import Foundation

@MainActor
final class RepositoryDetailViewModel: BaseViewModel {

    // MARK: - Properties

    @Injected(\.saveFavoriteRepositoryUseCase) private var saveFavoriteUseCase
    @Injected(\.removeFavoriteRepositoryUseCase) private var removeFavoriteUseCase
    @Injected(\.getFavoritesUseCase) private var getFavoritesUseCase

    let repository: RepositoryEntity

    @Published private(set) var isFavorite = false
    @Published private(set) var isSavingFavorite = false

    // MARK: - Lifecycle

    init(repository: RepositoryEntity) {
        self.repository = repository
    }

    // MARK: - Public Methods

    func onAppear() async {
        await refreshFavoriteState()
    }

    func toggleFavorite() async {
        isSavingFavorite = true
        defer { isSavingFavorite = false }

        do {
            if isFavorite {
                try await removeFavoriteUseCase.execute(repositoryID: repository.id)
                isFavorite = false
                showToast(NSLocalizedString("favorites.removed", comment: ""))
            } else {
                try await saveFavoriteUseCase.execute(repository: repository)
                isFavorite = true
                showToast(NSLocalizedString("favorites.saved", comment: ""))
            }
        } catch {
            showError(error)
        }
    }

    // MARK: - Private Methods

    private func refreshFavoriteState() async {
        do {
            let favorites = try await getFavoritesUseCase.execute()
            isFavorite = favorites.contains { $0.id == repository.id }
        } catch {
            isFavorite = false
        }
    }
}
