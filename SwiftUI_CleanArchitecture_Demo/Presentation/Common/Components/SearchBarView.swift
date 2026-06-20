//
//  SearchBarView.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import SwiftUI

struct SearchBarView: View {

    // MARK: - Properties

    @Binding var text: String
    let placeholder: String
    let onSubmit: () -> Void

    @State private var searchTask: Task<Void, Never>? = nil

    // MARK: - Body

    var body: some View {
        HStack(spacing: DesignTokens.Spacing.sm) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(AppColors.secondaryText)

            TextField(placeholder, text: $text)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .submitLabel(.search)
                .onSubmit(onSubmit)
                .onChange(of: text) { _ in
                    searchTask?.cancel()
                    searchTask = Task {
                        do {
                            try await Task.sleep(for: .milliseconds(300))
                            onSubmit()
                        } catch {
                            // Task was cancelled because the user typed another character
                        }
                    }
                }
                .accessibilityIdentifier("search_text_field")

            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(AppColors.secondaryText)
                }
                .accessibilityIdentifier("search_clear_button")
            }
        }
        .padding(DesignTokens.Spacing.sm)
        .background(AppColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.md))
        .accessibilityIdentifier("search_bar_view")
    }
}

#Preview {
    SearchBarView(text: .constant("swift"), placeholder: "Search repositories", onSubmit: {})
        .padding()
}
