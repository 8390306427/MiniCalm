//
//  Untitled.swift
//  MiniCalm
//
//  Created by Snehal Patil on 08/09/26.
//

import Foundation

enum TimeFormatter {

    static func string(seconds: Int) -> String {

        let minutes = seconds / 60
        let remainingSeconds = seconds % 60

        return String(
            format: "%02d:%02d",
            minutes,
            remainingSeconds
        )
    }

    static func string(seconds: Double) -> String {

        guard seconds.isFinite, seconds >= 0 else {
            return "00:00"
        }

        return string(seconds: Int(seconds))
    }
}
