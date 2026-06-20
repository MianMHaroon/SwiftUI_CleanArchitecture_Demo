//
//  ToastBannerView.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import SwiftUI

struct ToastBannerView: View {

    // MARK: - Properties

    let message: String
    let onDismiss: () -> Void

    // MARK: - Body

    var body: some View {
        Text(message)
            .font(AppTypography.caption)
            .foregroundStyle(AppColors.onAccent)
            .padding(.horizontal, DesignTokens.Spacing.md)
            .padding(.vertical, DesignTokens.Spacing.sm)
            .background(AppColors.accent)
            .clipShape(Capsule())
            .onTapGesture(perform: onDismiss)
            .task {
                try? await Task.sleep(for: .seconds(2.5))
                onDismiss()
            }
            .accessibilityIdentifier("toast_banner_view")
    }
}

#Preview {
    ToastBannerView(message: "Saved to favorites") {}
}
