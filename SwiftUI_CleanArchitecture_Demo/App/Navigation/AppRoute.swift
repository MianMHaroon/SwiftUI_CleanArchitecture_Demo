//
//  AppRoute.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Foundation

enum AppRoute: Hashable {
    case repositoryDetail(RepositoryEntity)
    case ownerDetail(OwnerEntity)
}

enum AppTab: Int, CaseIterable, Identifiable {
    case discover
    case favorites
    case trending
    case settings

    var id: Int { rawValue }

    var title: String {
        switch self {
        case .discover:
            return NSLocalizedString("tab.discover", comment: "")
        case .favorites:
            return NSLocalizedString("tab.favorites", comment: "")
        case .trending:
            return NSLocalizedString("tab.trending", comment: "")
        case .settings:
            return NSLocalizedString("tab.settings", comment: "")
        }
    }

    var systemImage: String {
        switch self {
        case .discover:
            return "magnifyingglass"
        case .favorites:
            return "star.fill"
        case .trending:
            return "chart.line.uptrend.xyaxis"
        case .settings:
            return "gearshape"
        }
    }
}

enum SheetRoute: Identifiable, Equatable {
    case settingsInfo

    var id: String {
        switch self {
        case .settingsInfo:
            return "settingsInfo"
        }
    }
}

enum FullScreenRoute: Identifiable, Equatable {
    case onboardingPlaceholder

    var id: String {
        switch self {
        case .onboardingPlaceholder:
            return "onboardingPlaceholder"
        }
    }
}
