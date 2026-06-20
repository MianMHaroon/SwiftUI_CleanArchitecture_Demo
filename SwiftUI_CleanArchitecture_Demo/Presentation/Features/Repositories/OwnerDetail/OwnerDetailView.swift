//
//  OwnerDetailView.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Combine
import SwiftUI

struct OwnerDetailView: View {

    // MARK: - Properties

    @ObservedObject var viewModel: OwnerDetailViewModel

    // MARK: - Body

    var body: some View {
        VStack(spacing: DesignTokens.Spacing.lg) {
            AsyncImage(url: viewModel.owner.avatarURL) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                AppColors.placeholder
            }
            .frame(width: 120, height: 120)
            .clipShape(Circle())
            .accessibilityIdentifier("owner_avatar")

            Text(viewModel.owner.login)
                .font(AppTypography.title)
                .foregroundStyle(AppColors.primaryText)
                .accessibilityIdentifier("owner_username")

            Link(
                viewModel.owner.htmlURL.absoluteString,
                destination: viewModel.owner.htmlURL
            )
            .font(AppTypography.body)
            .foregroundStyle(AppColors.accent)
            .accessibilityIdentifier("owner_profile_url")

            Spacer()
        }
        .padding(DesignTokens.Spacing.lg)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.appBackground)
        .navigationTitle(NSLocalizedString("owner.title", comment: ""))
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("owner_detail_view")
    }
}

#Preview {
    NavigationStack {
        OwnerDetailView(
            viewModel: OwnerDetailViewModel(
                owner: OwnerEntity(
                    id: 1,
                    login: "apple",
                    avatarURL: URL(string: "https://github.com/apple.png")!,
                    htmlURL: URL(string: "https://github.com/apple")!
                )
            )
        )
    }
}
