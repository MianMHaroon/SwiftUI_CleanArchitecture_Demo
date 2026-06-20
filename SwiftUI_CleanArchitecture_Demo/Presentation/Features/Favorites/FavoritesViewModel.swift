//
//  FavoritesViewModel.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Combine
import FactoryKit
import Foundation

@MainActor
final class FavoritesViewModel: BaseViewModel {

    // MARK: - Properties

    @Injected(\.getFavoritesUseCase) private var getFavoritesUseCase
    @Injected(\.removeFavoriteRepositoryUseCase) private var removeFavoriteUseCase

    @Published private(set) var state: ViewState<[RepositoryEntity]> = .idle

    // MARK: - Public Methods

    func loadFavorites() async {
        state = .loading
        do {
            let favorites = try await getFavoritesUseCase.execute()
            state = favorites.isEmpty ? .empty : .loaded(favorites)
        } catch {
            state = .error(error.localizedDescription)
        }
    }

    func removeFavorite(id: Int) async {
        handleLoadingIndicator(value: true)
        defer { handleLoadingIndicator(value: false) }

        do {
            try await removeFavoriteUseCase.execute(repositoryID: id)
            showToast(NSLocalizedString("favorites.removed", comment: ""))
            await loadFavorites()
        } catch {
            showError(error)
        }
    }
}
