//
//  APIError.swift
//  MiniCalm
//
//  Created by Snehal Patil on 08/09/26.
//

import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case serverError(Int)
    case decodingFailed
    case networkError(Error)
    case emptyResponse

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The server URL is invalid."

        case .invalidResponse:
            return "The server returned an invalid response."

        case .serverError(let statusCode):
            return "Server error: \(statusCode)."

        case .decodingFailed:
            return "Unable to read the meditation data."

        case .networkError:
            return "Unable to connect to the server."

        case .emptyResponse:
            return "No meditation sessions are available."
        }
    }
}
