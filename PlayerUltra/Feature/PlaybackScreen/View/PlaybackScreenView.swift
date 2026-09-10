//
//  PlaybackScreenView.swift
//  PlayerUltra
//
//  Created by NovikovValeriy on 10/09/2026.
//

import SwiftUI

fileprivate struct PlaybackScreenValues {
    struct IconNames {
        static let importFileButton = "folder.badge.plus"
        static let shuffleButtonIcon = "shuffle"
        static let backwardButtonIcon = "backward.end.fill"
        static let playButtonIcon = "play.fill"
        static let pauseButtonIcon = "pause.fill"
        static let forwardButtonIcon = "forward.end.fill"
        static let repeatQueueButtonIcon = "repeat"
        static let repeatTrackButtonIcon = "repeat.1"
    }
    struct Sizes {
        static let playbackButtonsSize: CGFloat = 30
    }
    struct ColorNames {
        static let playbackControlEnabledColor: Color = .accentColor
        static let playbackControlDisabledColor: Color = .gray
    }
}
fileprivate typealias Constants = PlaybackScreenValues

protocol ControlButtonState {
    var iconName: String { get }
    var iconColor: Color { get }
}

extension PlayButtonState: ControlButtonState {
    var iconName: String {
        switch self {
        case .play: return Constants.IconNames.playButtonIcon
        case .pause: return Constants.IconNames.pauseButtonIcon
        }
    }
    var iconColor: Color { return Constants.ColorNames.playbackControlEnabledColor }
}

extension ForwardButtonState: ControlButtonState {
    var iconName: String { return Constants.IconNames.forwardButtonIcon }
    var iconColor: Color { return Constants.ColorNames.playbackControlEnabledColor }
}

extension BackwardButtonState: ControlButtonState {
    var iconName: String { return Constants.IconNames.backwardButtonIcon }
    var iconColor: Color { return Constants.ColorNames.playbackControlEnabledColor }
}

extension ShuffleButtonState: ControlButtonState {
    var iconName: String { return Constants.IconNames.shuffleButtonIcon }
    var iconColor: Color {
        switch self {
        case .enabled: return Constants.ColorNames.playbackControlEnabledColor
        case .disabled: return Constants.ColorNames.playbackControlDisabledColor
        }
    }
}

extension RepeatButtonState: ControlButtonState {
    var iconName: String {
        switch self {
        case .disabled, .repeatQueue: return Constants.IconNames.repeatQueueButtonIcon
        case .repeatTrack: return Constants.IconNames.repeatTrackButtonIcon
        }
    }

    var iconColor: Color {
        switch self {
        case .repeatQueue, .repeatTrack: return Constants.ColorNames.playbackControlEnabledColor
        case .disabled: return Constants.ColorNames.playbackControlDisabledColor
        }
    }
}

struct PlaybackScreenView: View {
    @State private var viewModel = PlaybackScreenViewModelImpl()

    var body: some View {
        VStack {

            PlaybackAlbumDefaultView()

            HStack {
                VStack(alignment: .leading) {
                    Text(viewModel.trackName)
                        .font(.title)
                        .fontWeight(.semibold)
                    Text(viewModel.trackAuthor)
                        .font(.title2)
                        .fontWeight(.medium)
                }
                Spacer()
            }

            Slider(value: $viewModel.seekPointer)

            HStack {
                Text(viewModel.seekTimePosition)
                Spacer()
                Text(viewModel.seekTimeLeft)
            }

            HStack {
                PlaybackControlButton(buttonState: viewModel.shuffleButtonState) {
                    viewModel.shuffleButtonPressed()
                }

                Spacer()

                PlaybackControlButton(buttonState: viewModel.backwardButtonState) {
                    viewModel.backwardButtonPressed()
                }

                Spacer()

                PlaybackControlButton(buttonState: viewModel.playButtonState) {
                    viewModel.playButtonPressed()
                }

                Spacer()

                PlaybackControlButton(buttonState: viewModel.forwardButtonState) {
                    viewModel.forwardButtonPressed()
                }

                Spacer()

                PlaybackControlButton(buttonState: viewModel.repeatButtonState) {
                    viewModel.repeatButtonPressed()
                }
            }
            .padding([.vertical])
        }
        .padding([.horizontal])
        .toolbar {
            Button {
                viewModel.importFilePressed()
            } label: {
                Image(systemName: Constants.IconNames.importFileButton)
            }
            .fileImporter(
                isPresented: $viewModel.showFileImporter,
                allowedContentTypes: PUImportTypes.allowedImportTypes,
                allowsMultipleSelection: false
            ) { result in
                viewModel.importCallback(result: result)
            }
        }
    }
}

struct PlaybackControlButton: View {
    let buttonState: ControlButtonState
    let action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: buttonState.iconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: Constants.Sizes.playbackButtonsSize, height: Constants.Sizes.playbackButtonsSize)
                .foregroundStyle(buttonState.iconColor)
        }
    }
}

#Preview {
    PlaybackScreenView()
}
