//
//  RepositoryCardView.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import SwiftUI

struct RepositoryCardView: View {

    // MARK: - Properties

    let repository: RepositoryEntity

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: DesignTokens.Spacing.xs) {
            Text(repository.name)
                .font(AppTypography.headline)
                .foregroundStyle(AppColors.primaryText)
                .accessibilityIdentifier("repository_card_name")

            if let description = repository.description, !description.isEmpty {
                Text(description)
                    .font(AppTypography.body)
                    .foregroundStyle(AppColors.secondaryText)
                    .lineLimit(2)
            }

            HStack(spacing: DesignTokens.Spacing.md) {
                Label("\(repository.stars)", systemImage: "star.fill")
                Label("\(repository.forks)", systemImage: "tuningfork")
                if let language = repository.language {
                    Label(language, systemImage: "chevron.left.forwardslash.chevron.right")
                }
            }
            .font(AppTypography.caption)
            .foregroundStyle(AppColors.secondaryText)
        }
        .cardStyle()
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier("repository_card_\(repository.id)")
    }
}

#Preview {
    RepositoryCardView(
        repository: RepositoryEntity(
            id: 1,
            name: "swift",
            fullName: "apple/swift",
            description: "The Swift Programming Language",
            stars: 68000,
            forks: 10500,
            language: "Swift",
            htmlURL: URL(string: "https://github.com/apple/swift")!,
            owner: OwnerEntity(
                id: 1,
                login: "apple",
                avatarURL: URL(string: "https://github.com/apple.png")!,
                htmlURL: URL(string: "https://github.com/apple")!
            )
        )
    )
    .padding()
    .background(AppColors.appBackground)
}
