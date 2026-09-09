//
//  SessionRowView.swift
//  MiniCalm
//
//  Created by Snehal Patil on 08/09/26.
//

import SwiftUI

struct SessionRowView: View {

    let session: MeditationSession

    var body: some View {

        HStack(spacing: 12) {

            artwork

            VStack(alignment: .leading, spacing: 5) {

                Text(session.title)
                    .font(.headline)
                    .lineLimit(2)

                Text(session.teacher)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text(
                    TimeFormatter.string(
                        seconds: session.durationSeconds
                    )
                )
                .font(.caption)
                .foregroundStyle(.secondary)

                if session.isPremium {
                    Text("Premium")
                        .font(.caption2.bold())
                        .padding(.horizontal, 7)
                        .padding(.vertical, 3)
                        .background(.orange.opacity(0.15))
                        .clipShape(Capsule())
                }
            }

            Spacer()
        }
        .padding(.vertical, 6)
    }

    @ViewBuilder
    private var artwork: some View {
        if let artworkURL = session.artworkURL {
            AsyncImage(url: artworkURL) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()

                case .failure:
                    placeholderArtwork

                case .empty:
                    placeholderArtwork
                        .redacted(reason: .placeholder)

                @unknown default:
                    placeholderArtwork
                }
            }
            .frame(width: 70, height: 70)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        } else {
            placeholderArtwork
        }
    }
    
    private var placeholderArtwork: some View {
        Image(systemName: "music.note")
            .frame(width: 70, height: 70)
            .background(.gray.opacity(0.15))
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

struct SkeletonSessionRow: View {

    var body: some View {

        HStack(spacing: 12) {

            RoundedRectangle(cornerRadius: 8)
                .frame(width: 70, height: 70)

            VStack(alignment: .leading, spacing: 8) {

                RoundedRectangle(cornerRadius: 4)
                    .frame(width: 180, height: 16)

                RoundedRectangle(cornerRadius: 4)
                    .frame(width: 100, height: 13)

                RoundedRectangle(cornerRadius: 4)
                    .frame(width: 70, height: 11)
            }

            Spacer()
        }
        .padding(.vertical, 6)
    }
}
