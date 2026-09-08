//
//  APIClient.swift
//  MiniCalm
//
//  Created by Snehal Patil on 08/09/26.
//

import Foundation

protocol APIClientProtocol {
    func get<T: Decodable>(
        _ type: T.Type,
        from url: URL
    ) async throws -> T
}

final class APIClient: APIClientProtocol {

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func get<T: Decodable>(
        _ type: T.Type,
        from url: URL
    ) async throws -> T {

        do {
            let (data, response) = try await session.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.invalidResponse
            }

            guard 200...299 ~= httpResponse.statusCode else {
                throw APIError.serverError(httpResponse.statusCode)
            }

            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw APIError.decodingFailed
            }

        } catch let error as APIError {
            throw error
        } catch {
            throw APIError.networkError(error)
        }
    }
}
