//
//  PlayerViewControllerWrapper.swift
//  MiniCalm
//
//  Created by Snehal Patil on 09/09/26.
//

import SwiftUI
import UIKit

struct PlayerViewControllerWrapper: UIViewControllerRepresentable {

    let session: MeditationSession

    func makeUIViewController(
        context: Context
    ) -> PlayerViewController {

        PlayerViewController(session: session)
    }

    func updateUIViewController(
        _ uiViewController: PlayerViewController,
        context: Context
    ) {
      
    }
}
