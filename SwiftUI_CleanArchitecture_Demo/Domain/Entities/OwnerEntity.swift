//
//  OwnerEntity.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Foundation

struct OwnerEntity: Identifiable, Hashable, Codable, Sendable {
    let id: Int
    let login: String
    let avatarURL: URL
    let htmlURL: URL
}
