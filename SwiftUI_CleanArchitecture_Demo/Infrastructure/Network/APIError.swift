//
//  APIError.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Foundation

enum APIError: LocalizedError, Equatable {
    case invalidURL
    case invalidResponse
    case httpError(statusCode: Int, message: String?)
    case decodingFailed
    case networkUnavailable
    case unknown(String)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("error.invalid_url", comment: "")
        case .invalidResponse:
            return NSLocalizedString("error.invalid_response", comment: "")
        case .httpError(let statusCode, let message):
            if let message, !message.isEmpty {
                return message
            }
            return String(format: NSLocalizedString("error.http", comment: ""), statusCode)
        case .decodingFailed:
            return NSLocalizedString("error.decoding_failed", comment: "")
        case .networkUnavailable:
            return NSLocalizedString("error.network_unavailable", comment: "")
        case .unknown(let message):
            return message
        }
    }
}
