//
//  RepositoryMapper.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Foundation

enum RepositoryMapper {

    // MARK: - Public Methods

    static func map(_ dto: RepositoryDTO) -> RepositoryEntity? {
        guard
            let htmlURL = URL(string: dto.htmlUrl),
            let owner = map(dto.owner)
        else {
            return nil
        }
        return RepositoryEntity(
            id: dto.id,
            name: dto.name,
            fullName: dto.fullName,
            description: dto.description,
            stars: dto.stargazersCount,
            forks: dto.forksCount,
            language: dto.language,
            htmlURL: htmlURL,
            owner: owner
        )
    }
    
    @MainActor
    static func map(_ dtos: [RepositoryDTO]) -> [RepositoryEntity] {
        dtos.compactMap(map)
    }

    static func map(_ entity: OwnerDTO) -> OwnerEntity? {
        guard
            let avatarURL = URL(string: entity.avatarUrl),
            let htmlURL = URL(string: entity.htmlUrl)
        else {
            return nil
        }
        return OwnerEntity(
            id: entity.id,
            login: entity.login,
            avatarURL: avatarURL,
            htmlURL: htmlURL
        )
    }
}
