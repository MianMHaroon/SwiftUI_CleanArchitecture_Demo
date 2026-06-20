//
//  RepositoryEntity.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Foundation

struct RepositoryEntity: Identifiable, Hashable, Codable, Sendable {
    let id: Int
    let name: String
    let fullName: String
    let description: String?
    let stars: Int
    let forks: Int
    let language: String?
    let htmlURL: URL
    let owner: OwnerEntity
}
