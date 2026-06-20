//
//  APIClient.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Foundation

protocol APIClientProtocol: Sendable {
    func request<T: Decodable>(_ endpoint: APIEndpoint) async throws -> T
}

struct APIEndpoint: Sendable {
    let path: String
    let method: HTTPMethod
    let queryItems: [URLQueryItem]

    init(path: String, method: HTTPMethod = .get, queryItems: [URLQueryItem] = []) {
        self.path = path
        self.method = method
        self.queryItems = queryItems
    }
}

enum HTTPMethod: String, Sendable {
    case get = "GET"
}

final class APIClient: APIClientProtocol, @unchecked Sendable {

    // MARK: - Properties

    private let session: URLSession
    private let baseURL: URL
    private let decoder: JSONDecoder

    // MARK: - Lifecycle

    init(
        session: URLSession = .shared,
        baseURL: URL = APIConstants.baseURL,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.session = session
        self.baseURL = baseURL
        self.decoder = decoder
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    // MARK: - Public Methods

    func request<T: Decodable>(_ endpoint: APIEndpoint) async throws -> T {
        let request = try buildRequest(for: endpoint)
        let (data, response) = try await session.data(for: request)
        try validate(response: response, data: data)
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw APIError.decodingFailed
        }
    }

    // MARK: - Private Methods

    private func buildRequest(for endpoint: APIEndpoint) throws -> URLRequest {
        guard var components = URLComponents(url: baseURL.appendingPathComponent(endpoint.path), resolvingAgainstBaseURL: false) else {
            throw APIError.invalidURL
        }
        if !endpoint.queryItems.isEmpty {
            components.queryItems = endpoint.queryItems
        }
        guard let url = components.url else {
            throw APIError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.setValue(APIConstants.acceptHeader, forHTTPHeaderField: "Accept")
        request.setValue(APIConstants.userAgent, forHTTPHeaderField: "User-Agent")
        return request
    }

    private func validate(response: URLResponse, data: Data) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        guard (200...299).contains(httpResponse.statusCode) else {
            let message = String(data: data, encoding: .utf8)
            throw APIError.httpError(statusCode: httpResponse.statusCode, message: message)
        }
    }
}
