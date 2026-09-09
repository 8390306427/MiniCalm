//
//  LibraryViewState.swift
//  MiniCalm
//
//  Created by Snehal Patil on 08/09/26.
//

import Foundation

struct SessionsResponse: Decodable {
    let sessions: [MeditationSession]
}


struct LibraryViewState {

    enum Status {
        case idle
        case loading
        case loaded
        case failed
        case empty
    }

    var status: Status = .idle
    var sessions: [MeditationSession] = []
    var errorMessage: String?
}
