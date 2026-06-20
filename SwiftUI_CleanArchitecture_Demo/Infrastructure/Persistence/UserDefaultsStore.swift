//
//  UserDefaultsStore.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Foundation

enum UserDefaultsKey: String {
    case favorites = "favorites.repositories"
}

protocol UserDefaultsStoreProtocol: Sendable {
    func data(for key: UserDefaultsKey) -> Data?
    func set(_ data: Data?, for key: UserDefaultsKey)
    func removeValue(for key: UserDefaultsKey)
}

final class UserDefaultsStore: UserDefaultsStoreProtocol, @unchecked Sendable {

    // MARK: - Properties

    private let userDefaults: UserDefaults

    // MARK: - Lifecycle

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    // MARK: - Public Methods

    func data(for key: UserDefaultsKey) -> Data? {
        userDefaults.data(forKey: key.rawValue)
    }

    func set(_ data: Data?, for key: UserDefaultsKey) {
        userDefaults.set(data, forKey: key.rawValue)
    }

    func removeValue(for key: UserDefaultsKey) {
        userDefaults.removeObject(forKey: key.rawValue)
    }
}
