//
//  PlaybackAlbumDefaultView.swift
//  PlayerUltra
//
//  Created by NovikovValeriy on 10/09/2026.
//

import SwiftUI

fileprivate struct PlaybackAlbumDefaultValues {
    static let backgroundColor: FillShapeStyle = .fill
    static let shadowRadius: CGFloat = 20
    static let iconSize: CGFloat = 100
    static let imageName = "music.note"
}
fileprivate typealias Constants = PlaybackAlbumDefaultValues

struct PlaybackAlbumDefaultView: View {
    var body: some View {
        Rectangle()
            .fill(Constants.backgroundColor)
            .aspectRatio(1.0, contentMode: .fit)
            .shadow(radius: Constants.shadowRadius)
            .padding([.vertical])
            .overlay(
                Image(systemName: Constants.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(
                        width: Constants.iconSize,
                        height: Constants.iconSize
                    )
                    .foregroundStyle(.white)
            )
    }
}

#Preview {
    PlaybackAlbumDefaultView()
}
