//
//  PlayerViewController.swift
//  MiniCalm
//
//  Created by Snehal Patil on 08/09/26.
//

import UIKit

class PlayerViewController: UIViewController {
    private let session: MeditationSession
    private let viewModel: PlayerViewModel
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var teacherLabel: UILabel!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var speedButton: UIButton!
    
    init(session: MeditationSession) {

        self.session = session
        self.viewModel = PlayerViewModel(session: session)

        super.init(
            nibName: "PlayerViewController",
            bundle: nil
        )
    }

       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("PLAYER SESSION:")
        print("Title:", session.title)
        print("Artwork URL:", session.artworkURL as Any)
        self.loadArtwork()
        self.setupUI()
        viewModel.loadAudio()
        print("Selected session: \(session.title)")
    }

    private func setupUI() {

            titleLabel.text = session.title
            teacherLabel.text = session.teacher

            currentTimeLabel.text = "00:00"

            durationLabel.text = TimeFormatter.string(
                seconds: session.durationSeconds
            )

            progressSlider.minimumValue = 0
            progressSlider.maximumValue = Float(session.durationSeconds)
            progressSlider.value = 0

            speedButton.setTitle("1.0x", for: .normal)
        }
    
    private func loadArtwork() {
        guard let url = session.artworkURL else {
            artworkImageView.image = UIImage(systemName: "music.note")
            return
        }

        artworkImageView.image = nil

        Task { [weak self] in
            do {
                let (data, response) = try await URLSession.shared.data(from: url)

                guard let httpResponse = response as? HTTPURLResponse,
                      200...299 ~= httpResponse.statusCode,
                      let image = UIImage(data: data) else {
                    return
                }

                await MainActor.run {
                    self?.artworkImageView.image = image
                }

            } catch {
                print("Artwork loading failed:", error)

                await MainActor.run {
                    self?.artworkImageView.image = UIImage(systemName: "music.note")
                }
            }
        }
    }
    
    @IBAction func playPauseButtonTapped(_ sender: UIButton) {
   
        viewModel.togglePlayPause()

        sender.setTitle(
            viewModel.isPlaying ? "❚❚" : "▶",
            for: .normal
        )
    }

}
