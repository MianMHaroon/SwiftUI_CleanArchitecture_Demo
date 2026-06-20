//
//  View+Ext.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import SwiftUI

extension View {

    func progressOverlay(isLoading: Binding<Bool>, message: String? = nil) -> some View {
        overlay {
            if isLoading.wrappedValue {
                ZStack {
                    Color.loadingOverlay
                        .ignoresSafeArea()

                    VStack(spacing: DesignTokens.Spacing.sm) {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .scaleEffect(1.5)

                        if let message, !message.isEmpty {
                            Text(message)
                                .font(AppTypography.caption)
                                .foregroundStyle(Color.secondaryText)
                        }
                    }
                    .padding(DesignTokens.Spacing.lg)
                    .background(
                        RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.md)
                            .fill(Color.appCellBG)
                    )
                }
                .transition(.opacity)
                .accessibilityIdentifier("progress_overlay")
            }
        }
        .animation(.easeInOut(duration: 0.2), value: isLoading.wrappedValue)
    }

    func progressOverlay(isLoading: Bool, message: String? = nil) -> some View {
        progressOverlay(
            isLoading: .constant(isLoading),
            message: message
        )
    }

    func bindAppState(to viewModel: BaseViewModel, appState: AppState) -> some View {
        onAppear { [weak viewModel] in
            viewModel?.setAppState(appState)
        }
    }

    func cardStyle() -> some View {
        padding(DesignTokens.Spacing.md)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.appCellBG)
            .clipShape(RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.md))
    }

    func responsiveFrame(width: CGFloat? = nil, height: CGFloat? = nil, alignment: Alignment = .center) -> some View {
        let multiplier: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 1.5 : 1.0
        return frame(
            width: width.map { $0 * multiplier },
            height: height.map { $0 * multiplier },
            alignment: alignment
        )
    }

    func responsivePadding(
        all: CGFloat? = nil,
        horizontal: CGFloat? = nil,
        vertical: CGFloat? = nil,
        top: CGFloat? = nil,
        bottom: CGFloat? = nil,
        leading: CGFloat? = nil,
        trailing: CGFloat? = nil
    ) -> some View {
        let multiplier: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 1.5 : 1.0

        return padding(.top, (top ?? vertical ?? all ?? 0) * multiplier)
            .padding(.bottom, (bottom ?? vertical ?? all ?? 0) * multiplier)
            .padding(.leading, (leading ?? horizontal ?? all ?? 0) * multiplier)
            .padding(.trailing, (trailing ?? horizontal ?? all ?? 0) * multiplier)
    }
}
