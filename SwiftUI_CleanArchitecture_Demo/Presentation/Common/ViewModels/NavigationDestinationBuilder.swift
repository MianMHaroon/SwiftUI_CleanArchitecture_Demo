//
//  NavigationDestinationBuilder.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import SwiftUI

enum NavigationDestinationBuilder {

    // MARK: - Public Methods

    @ViewBuilder
    static func destination(for route: AppRoute) -> some View {
        switch route {
        case .repositoryDetail(let repository):
            RepositoryDetailView(viewModel: RepositoryDetailViewModel(repository: repository))
        case .ownerDetail(let owner):
            OwnerDetailView(viewModel: OwnerDetailViewModel(owner: owner))
        }
    }
}
