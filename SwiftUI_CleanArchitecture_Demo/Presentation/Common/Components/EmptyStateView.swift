//
//  EmptyStateView.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import SwiftUI

struct EmptyStateView: View {

    // MARK: - Properties

    let title: String
    let message: String
    let systemImage: String

    // MARK: - Body

    var body: some View {
        VStack(spacing: DesignTokens.Spacing.sm) {
            Image(systemName: systemImage)
                .font(.system(size: DesignTokens.IconSize.lg))
                .foregroundStyle(AppColors.secondaryText)

            Text(title)
                .font(AppTypography.headline)
                .foregroundStyle(AppColors.primaryText)

            Text(message)
                .font(AppTypography.body)
                .foregroundStyle(AppColors.secondaryText)
                .multilineTextAlignment(.center)
        }
        .padding(DesignTokens.Spacing.lg)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .accessibilityIdentifier("empty_state_view")
    }
}

#Preview {
    EmptyStateView(
        title: "No Favorites",
        message: "Save repositories to see them here.",
        systemImage: "star"
    )
}
