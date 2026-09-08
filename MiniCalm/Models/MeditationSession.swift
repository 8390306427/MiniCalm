//
//  Untitled.swift
//  MiniCalm
//
//  Created by Snehal Patil on 08/09/26.
//

import Foundation

struct MeditationSession: Codable, Identifiable {
    let id: String
    let title: String
    let teacher: String
    let durationSeconds: Int
    let artworkURL: URL?
    let audioURL: URL?
    let isPremium: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case teacher
        case durationSeconds = "duration_seconds"
        case artworkURL = "artwork_url"
        case audioURL = "audio_url"
        case isPremium = "is_premium"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = (try? container.decode(String.self, forKey: .id))
            ?? UUID().uuidString

        title = (try? container.decode(String.self, forKey: .title))
            ?? "Untitled Meditation"

        teacher = (try? container.decode(String.self, forKey: .teacher))
            ?? "Unknown Teacher"

        durationSeconds = max(
            0,
            (try? container.decode(Int.self, forKey: .durationSeconds)) ?? 0
        )

        artworkURL = try? container.decode(URL.self, forKey: .artworkURL)

        audioURL = try? container.decode(URL.self, forKey: .audioURL)

        isPremium = (try? container.decode(Bool.self, forKey: .isPremium))
            ?? false
    }
}
