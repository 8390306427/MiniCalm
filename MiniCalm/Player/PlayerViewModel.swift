//
//  PlayerViewModel.swift
//  MiniCalm
//
//  Created by Snehal Patil on 08/09/26.
//

import Foundation

final class PlayerViewModel {

    private let session: MeditationSession
    private let audioPlayerManager: AudioPlayerManager
    var onTimeUpdate: ((Double) -> Void)?

    init(
        session: MeditationSession,
        audioPlayerManager: AudioPlayerManager = AudioPlayerManager()
    ) {
        self.session = session
        self.audioPlayerManager = audioPlayerManager
    }

    var title: String {
        session.title
    }

    var teacher: String {
        session.teacher
    }

    var durationSeconds: Int {
        session.durationSeconds
    }
    
    func seek(to seconds: Double) {
        audioPlayerManager.seek(to: seconds)
    }

    func loadAudio() {
        guard let audioURL = session.audioURL else {
            print("No audio URL available")
            return
        }

        audioPlayerManager.load(url: audioURL)
        
        audioPlayerManager.startTimeObserver { [weak self] seconds in
            self?.onTimeUpdate?(seconds)
        }
    }

    func togglePlayPause() {
        audioPlayerManager.togglePlayPause()
    }

    var isPlaying: Bool {
        audioPlayerManager.isPlaying
    }
}
