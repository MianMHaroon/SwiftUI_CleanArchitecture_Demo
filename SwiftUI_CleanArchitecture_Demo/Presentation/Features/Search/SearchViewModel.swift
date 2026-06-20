//
//  SearchViewModel.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Combine
import FactoryKit
import Foundation

@MainActor
final class SearchViewModel: BaseViewModel {

    // MARK: - Properties

    @Injected(\.searchRepositoriesUseCase) private var searchRepositoriesUseCase

    @Published var query = ""
    @Published private(set) var state: ViewState<[RepositoryEntity]> = .idle

    // MARK: - Public Methods

    func search(isNetworkAvailable: Bool) async {
        guard isNetworkAvailable else {
            state = .error(APIError.networkUnavailable.localizedDescription)
            return
        }

        guard !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            state = .idle
            return
        }

        state = .loading
        do {
            let repositories = try await searchRepositoriesUseCase.execute(query: query)
            state = repositories.isEmpty ? .empty : .loaded(repositories)
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}
