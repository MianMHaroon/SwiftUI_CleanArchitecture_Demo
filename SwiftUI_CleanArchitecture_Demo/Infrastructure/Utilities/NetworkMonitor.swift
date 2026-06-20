//
//  NetworkMonitor.swift
//  SwiftUI_CleanArchitecture_Demo
//
//  Created by Muhammad Haroon on 17/06/2026.
//

import Combine
import Foundation
import Network

@MainActor
final class NetworkMonitor: ObservableObject {

    // MARK: - Properties

    @Published private(set) var isConnected = true

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "com.swiftui.cleanarchitecture.networkmonitor")

    // MARK: - Lifecycle

    init() {
        startMonitoring()
    }

    deinit {
        monitor.cancel()
    }

    // MARK: - Private Methods

    private func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self else { return }
            Task { @MainActor in
                self.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
}
