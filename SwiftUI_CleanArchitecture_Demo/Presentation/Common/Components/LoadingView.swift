//
//  LoadingView.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import SwiftUI

struct LoadingView: View {

    // MARK: - Properties

    let message: String

    // MARK: - Body

    var body: some View {
        ZStack {
            AppColors.loadingOverlay
                .ignoresSafeArea()

            VStack(spacing: DesignTokens.Spacing.sm) {
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(1.5)
                Text(message)
                    .font(AppTypography.caption)
                    .foregroundStyle(AppColors.secondaryText)
            }
            .padding(DesignTokens.Spacing.lg)
            .background(
                RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.md)
                    .fill(AppColors.cardBackground)
            )
        }
        .accessibilityIdentifier("loading_view")
    }
}

#Preview {
    LoadingView(message: "Loading...")
}
