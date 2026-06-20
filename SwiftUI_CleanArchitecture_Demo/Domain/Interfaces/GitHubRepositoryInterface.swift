//
//  GitHubRepositoryInterface.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Foundation

protocol GitHubRepositoryInterface: Sendable {
    func searchRepositories(query: String) async throws -> [RepositoryEntity]
}
