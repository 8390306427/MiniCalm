//
//  SessionService.swift
//  MiniCalm
//
//  Created by Snehal Patil on 08/09/26.
//

import Foundation

protocol SessionServiceProtocol {
    func fetchSessions() async throws -> [MeditationSession]
}

final class SessionService: SessionServiceProtocol {

    private let apiClient: APIClientProtocol

    private let sessionsURL = URL(
        string: "https://gist.githubusercontent.com/Manojsuthar2000/441d8e745e124afe601fb85fb1c49a31/raw/sessions.json"
    )

    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }

    func fetchSessions() async throws -> [MeditationSession] {
        guard let url = sessionsURL else {
            throw APIError.invalidURL
        }

        let response = try await apiClient.get(
            SessionsResponse.self,
            from: url
        )

        guard !response.sessions.isEmpty else {
            throw APIError.emptyResponse
        }

        return response.sessions
    }
}
