//
//  RepositoryDTO.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Foundation

struct OwnerDTO: Decodable, Sendable {
    let id: Int
    let login: String
    let avatarUrl: String
    let htmlUrl: String
}

struct RepositoryDTO: Decodable, Sendable {
    let id: Int
    let name: String
    let fullName: String
    let description: String?
    let stargazersCount: Int
    let forksCount: Int
    let language: String?
    let htmlUrl: String
    let owner: OwnerDTO
}

struct SearchRepositoriesResponseDTO: Decodable, Sendable {
    let totalCount: Int
    let items: [RepositoryDTO]
}
