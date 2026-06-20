//
//  Container+Dependencies.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import FactoryKit
import Foundation

@MainActor
extension Container {

    // MARK: - Infrastructure

    var apiClient: Factory<APIClientProtocol> {
        self { APIClient() }
    }

    var userDefaultsStore: Factory<UserDefaultsStoreProtocol> {
        self { UserDefaultsStore() }
    }

    // MARK: - Data Sources

    var githubRemoteDataSource: Factory<GitHubRemoteDataSourceProtocol> {
        self {
            GitHubRemoteDataSource(apiClient: self.apiClient())
        }
    }

    var favoritesLocalDataSource: Factory<FavoritesLocalDataSourceProtocol> {
        self {
            FavoritesLocalDataSource(store: self.userDefaultsStore())
        }
    }

    // MARK: - Repositories

    var githubRepository: Factory<GitHubRepositoryInterface> {
        self {
            GitHubRepository(remoteDataSource: self.githubRemoteDataSource())
        }
    }

    var favoritesRepository: Factory<FavoritesRepositoryInterface> {
        self {
            FavoritesRepository(localDataSource: self.favoritesLocalDataSource())
        }
    }

    // MARK: - Use Cases

    var searchRepositoriesUseCase: Factory<SearchRepositoriesUseCaseProtocol> {
        self {
            SearchRepositoriesUseCase(repository: self.githubRepository())
        }
    }

    var getTrendingRepositoriesUseCase: Factory<GetTrendingRepositoriesUseCaseProtocol> {
        self {
            GetTrendingRepositoriesUseCase(repository: self.githubRepository())
        }
    }

    var saveFavoriteRepositoryUseCase: Factory<SaveFavoriteRepositoryUseCaseProtocol> {
        self {
            SaveFavoriteRepositoryUseCase(repository: self.favoritesRepository())
        }
    }

    var removeFavoriteRepositoryUseCase: Factory<RemoveFavoriteRepositoryUseCaseProtocol> {
        self {
            RemoveFavoriteRepositoryUseCase(repository: self.favoritesRepository())
        }
    }

    var getFavoritesUseCase: Factory<GetFavoritesUseCaseProtocol> {
        self {
            GetFavoritesUseCase(repository: self.favoritesRepository())
        }
    }

    var clearFavoritesCacheUseCase: Factory<ClearFavoritesCacheUseCaseProtocol> {
        self {
            ClearFavoritesCacheUseCase(repository: self.favoritesRepository())
        }
    }

    // MARK: - ViewModels

    var searchViewModel: Factory<SearchViewModel> {
        self { SearchViewModel() }
    }

    var favoritesViewModel: Factory<FavoritesViewModel> {
        self { FavoritesViewModel() }
    }

    var trendingViewModel: Factory<TrendingViewModel> {
        self { TrendingViewModel() }
    }

    var settingsViewModel: Factory<SettingsViewModel> {
        self { SettingsViewModel() }
    }
}
