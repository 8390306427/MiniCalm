//
//  AudioPlayerManager.swift
//  MiniCalm
//
//  Created by Snehal Patil on 08/09/26.
//

import Foundation
import AVFoundation

final class AudioPlayerManager {

    private var player: AVPlayer?
    private var timeObserver: Any?
    private var playbackRate: Float = 1.0
    

    var isPlaying: Bool {
        player?.timeControlStatus == .playing
    }

    func load(url: URL) {
        configureAudioSession()
        player = AVPlayer(url: url)
    }
    
    func startTimeObserver(
        onTimeUpdate: @escaping (Double) -> Void
    ) {
        guard let player = player else {
            return
        }

        timeObserver = player.addPeriodicTimeObserver(
            forInterval: CMTime(seconds: 0.5, preferredTimescale: 600),
            queue: .main
        ) { time in
            let seconds = time.seconds

            guard seconds.isFinite else {
                return
            }

            onTimeUpdate(seconds)
        }
    }

    func play() {
        player?.play()
    }

    func pause() {
        player?.pause()
    }
    
    func setPlaybackRate(_ rate: Float) {
        playbackRate = rate
        player?.rate = rate
    }

    func togglePlayPause() {
        if isPlaying {
            pause()
        } else {
            play()
        }
    }
    
    func seek(to seconds: Double) {
        let time = CMTime(
            seconds: seconds,
            preferredTimescale: 600
        )

        player?.seek(to: time)
    }
    
    private func configureAudioSession() {
        do {
            let audioSession = AVAudioSession.sharedInstance()

            try audioSession.setCategory(
                .playback,
                mode: .spokenAudio,
                options: []
            )

            try audioSession.setActive(true)
        } catch {
            print("Audio session setup failed:", error)
        }
    }
    
    func onPlaybackCompleted(
        _ completion: @escaping () -> Void
    ) {
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player?.currentItem,
            queue: .main
        ) { _ in
            completion()
        }
    }
}
