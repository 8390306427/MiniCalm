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

    var isPlaying: Bool {
        player?.timeControlStatus == .playing
    }

    func load(url: URL) {
        player = AVPlayer(url: url)
    }

    func play() {
        player?.play()
    }

    func pause() {
        player?.pause()
    }

    func togglePlayPause() {
        if isPlaying {
            pause()
        } else {
            play()
        }
    }
}
