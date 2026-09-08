//
//  LibraryView.swift
//  MiniCalm
//
//  Created by Snehal Patil on 08/09/26.
//

import SwiftUI

struct LibraryView: View {

    @State private var state = LibraryViewState()

    private let viewModel = LibraryViewModel()

    var body: some View {

        if #available(iOS 16.0, *) {
            NavigationStack {
                
                content
                    .navigationTitle("MiniCalm")
                    .task {
                        await loadSessions()
                    }
                    .refreshable {
                        await loadSessions()
                    }
            }
        } else {
            // Fallback on earlier versions
        }
    }

    @ViewBuilder
    private var content: some View {

        switch state.status {

        case .idle, .loading:
            skeletonList

        case .loaded:
            sessionList

        case .failed:
            errorView
        }
    }

    private var skeletonList: some View {

        List {
            ForEach(0..<8, id: \.self) { _ in
                SkeletonSessionRow()
            }
        }
        .redacted(reason: .placeholder)
        .disabled(true)
    }

    private var sessionList: some View {

        List(state.sessions) { session in

            Button {
                openPlayer(session)
            } label: {
                SessionRowView(session: session)
            }
            .buttonStyle(.plain)
        }
    }

    private var errorView: some View {

        VStack(spacing: 16) {

            Image(systemName: "wifi.exclamationmark")
                .font(.system(size: 40))

            Text("Unable to load sessions")
                .font(.headline)

            if let message = state.errorMessage {
                Text(message)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
            }

            Button("Try Again") {
                Task {
                    await loadSessions()
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }

    private func loadSessions() async {

        state.status = .loading
        state.errorMessage = nil

        let newState = await viewModel.loadSessions()

        state = newState
    }

    private func openPlayer(_ session: MeditationSession) {
        // UIKit navigation will be added here.
    }
}
