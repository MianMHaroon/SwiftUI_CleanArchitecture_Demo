//
//  ErrorView.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import SwiftUI

struct ErrorView: View {

    // MARK: - Properties

    let message: String
    let retryAction: (() -> Void)?

    // MARK: - Body

    var body: some View {
        VStack(spacing: DesignTokens.Spacing.md) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: DesignTokens.IconSize.lg))
                .foregroundStyle(AppColors.destructive)

            Text(message)
                .font(AppTypography.body)
                .multilineTextAlignment(.center)
                .foregroundStyle(AppColors.secondaryText)

            if let retryAction {
                Button(NSLocalizedString("action.retry", comment: ""), action: retryAction)
                    .buttonStyle(.borderedProminent)
                    .tint(AppColors.accent)
                    .accessibilityIdentifier("error_retry_button")
            }
        }
        .padding(DesignTokens.Spacing.lg)
        .accessibilityIdentifier("error_view")
    }
}

#Preview {
    ErrorView(message: "Something went wrong", retryAction: {})
}
