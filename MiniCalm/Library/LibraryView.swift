//
//  LibraryView.swift
//  MiniCalm
//
//  Created by Snehal Patil on 08/09/26.
//

import SwiftUI

import SwiftUI

struct LibraryView: View {

    @State private var state = LibraryViewState()
    @State private var selectedSession: MeditationSession?

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
                    .sheet(item: $selectedSession) { session in
                        PlayerViewControllerWrapper(session: session)
                    }
            }

        } else {

            NavigationView {
                content
                    .navigationTitle("MiniCalm")
                    .sheet(item: $selectedSession) { session in
                        PlayerViewControllerWrapper(session: session)
                    }
            }
        }
    }

    // MARK: - Content

    @ViewBuilder
    private var content: some View {

        switch state.status {

        case .idle, .loading:
            skeletonList

        case .loaded:
            sessionList

        case .empty:
            emptyView

        case .failed:
            errorView
        }
    }

    // MARK: - Skeleton

    private var skeletonList: some View {

        List {
            ForEach(0..<8, id: \.self) { _ in
                SkeletonSessionRow()
            }
        }
        .redacted(reason: .placeholder)
        .disabled(true)
    }

    // MARK: - Session List

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

    // MARK: - Empty

    private var emptyView: some View {

        VStack(spacing: 16) {

            Image(systemName: "music.note.list")
                .font(.system(size: 40))

            Text("No meditation sessions")
                .font(.headline)

            Text("There are currently no sessions available.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }

    // MARK: - Error

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

    // MARK: - Load Sessions

    private func loadSessions() async {

        state.status = .loading
        state.errorMessage = nil

        let newState = await viewModel.loadSessions()

        state = newState
    }

    // MARK: - Open Player

    private func openPlayer(_ session: MeditationSession) {

        selectedSession = session
    }
}
