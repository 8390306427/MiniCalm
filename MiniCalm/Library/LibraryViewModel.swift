//
//  LibraryViewModel.swift
//  MiniCalm
//
//  Created by Snehal Patil on 08/09/26.
//

import Foundation

@MainActor
struct LibraryViewModel {

    private let service: SessionServiceProtocol

    init(service: SessionServiceProtocol = SessionService()) {
        self.service = service
    }

    func loadSessions() async -> LibraryViewState {

        do {
            let sessions = try await service.fetchSessions()

            return LibraryViewState(
                status: .loaded,
                sessions: sessions,
                errorMessage: nil
            )

        } catch {
            return LibraryViewState(
                status: .failed,
                sessions: [],
                errorMessage: error.localizedDescription
            )
        }
    }
}
