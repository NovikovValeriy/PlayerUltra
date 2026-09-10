//
//  PlaybackScreenViewModel.swift
//  PlayerUltra
//
//  Created by NovikovValeriy on 10/09/2026.
//

import Foundation

enum PlayButtonState {
    case pause
    case play
}

enum ForwardButtonState {
    case none
}

enum BackwardButtonState {
    case none
}

enum ShuffleButtonState {
    case enabled
    case disabled
}

enum RepeatButtonState {
    case disabled
    case repeatQueue
    case repeatTrack
}

protocol PlaybackScreenViewModel {
    func shuffleButtonPressed()
    func backwardButtonPressed()
    func playButtonPressed()
    func forwardButtonPressed()
    func repeatButtonPressed()
    func importFilePressed()
    func importCallback(result: Result<[URL], any Error>)
}

@Observable
class PlaybackScreenViewModelImpl: PlaybackScreenViewModel {
    var seekPointer: Float = 0.3
    var showFileImporter = false
    private(set) var playButtonState: PlayButtonState = .play
    private(set) var forwardButtonState: ForwardButtonState = .none
    private(set) var backwardButtonState: BackwardButtonState = .none
    private(set) var shuffleButtonState: ShuffleButtonState  = .disabled
    private(set) var repeatButtonState: RepeatButtonState = .disabled
    private(set) var trackName: String = "Unknown"
    private(set) var trackAuthor: String = "Unknown"
    private(set) var seekTimePosition: String = "0:00"
    private(set) var seekTimeLeft: String = "-2:00"

    func shuffleButtonPressed() {
        switch shuffleButtonState {
        case .enabled:
            shuffleButtonState = .disabled
        case .disabled:
            shuffleButtonState = .enabled
        }
    }

    func backwardButtonPressed() {

    }

    func playButtonPressed() {
        switch playButtonState {
        case .pause:
            playButtonState = .play
        case .play:
            playButtonState = .pause
        }
    }

    func forwardButtonPressed() {
        
    }

    func repeatButtonPressed() {
        switch repeatButtonState {
        case .disabled:
            repeatButtonState = .repeatQueue
        case .repeatQueue:
            repeatButtonState = .repeatTrack
        case .repeatTrack:
            repeatButtonState = .disabled
        }
    }

    func importFilePressed() {
        showFileImporter = true
    }

    func importCallback(result: Result<[URL], any Error>) {
        switch result {
        case .success(let files):
            print()
        case .failure(let error):
            print()
        }
    }
}
