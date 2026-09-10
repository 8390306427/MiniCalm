MiniCalm

A small iOS meditation app built as part of the iOS development assignment.

How to Run
1. Clone the repository.
2. Open MiniCalm.xcodeproj in Xcode.
3. Select an iOS Simulator or connected iPhone.
4. Build and run the application.

No third-party package installation is required.

Architecture
The project uses MVVM with a combination of SwiftUI and UIKit/XIB.
* Library – SwiftUI-based meditation session list with skeleton loading, pull-to-refresh, empty and error states.
* Player – UIKit/XIB-based audio player.
* ViewModels – Handle presentation logic and keep views/controllers lightweight.
* Network – URLSession with async/await for API communication.
* Models – Codable models for the meditation session data.
* Audio – AVPlayer is used for playback, including playback speed and background audio support.
The player is presented full-screen from the SwiftUI Library screen using UIViewControllerRepresentable.

What I Would Do Differently With More Time
* Add proper image caching so artwork remains consistent across screens and refreshes.
* Add unit tests for ViewModels, networking, and playback-related logic.
* Improve accessibility, including Dynamic Type and VoiceOver support.
* Add more robust playback state restoration when the application is terminated or interrupted.
* Add a dedicated networking layer with better request/retry handling for production use.
* Further refine the Player UI and loading/error states.

AI Assistance
I used AI assistance (ChatGPT) during development.
AI was mainly used for:

* Getting guidance on SwiftUI implementation details.
* Debugging and troubleshooting development issues.
* Drafting and refining the README/documentation.

The application implementation, integration, testing, and final code decisions were performed and verified by me.

Known Considerations

* The provided API uses picsum.photos for artwork URLs.
* Picsum may return different artwork when the library is refreshed or when the same artwork URL is requested again from another screen.
* As a result, the artwork displayed in the Library and Player may differ even though the selected meditation session and artwork URL are the same.
* The application intentionally uses the provided API data without modifying it.
* In a production environment, stable CDN image URLs and image caching would be recommended to ensure consistent artwork across screens and refreshes.
