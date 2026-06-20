//
//  OwnerDetailViewModel.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Combine
import Foundation

@MainActor
final class OwnerDetailViewModel: ObservableObject {

    // MARK: - Properties

    let owner: OwnerEntity

    // MARK: - Lifecycle

    init(owner: OwnerEntity) {
        self.owner = owner
    }
}
