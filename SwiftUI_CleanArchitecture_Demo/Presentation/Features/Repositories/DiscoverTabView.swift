//
//  DiscoverTabView.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Combine
import FactoryKit
import SwiftUI

struct DiscoverTabView: View {

    // MARK: - Properties

    @InjectedObject(\.searchViewModel) private var searchViewModel
    @EnvironmentObject private var coordinator: AppCoordinator

    // MARK: - Body

    var body: some View {
        NavigationStack(path: $coordinator.discoverPath) {
            SearchView(viewModel: searchViewModel)
                .navigationDestination(for: AppRoute.self) { route in
                    NavigationDestinationBuilder.destination(for: route)
                }
        }
    }
}

#Preview {
    DiscoverTabView()
        .environmentObject(AppCoordinator(appState: AppState()))
}
