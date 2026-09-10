//
//  PUImportTypes.swift
//  PlayerUltra
//
//  Created by NovikovValeriy on 10/09/2026.
//

import UniformTypeIdentifiers

enum PUImportTypes: String, CaseIterable, Identifiable {
    case mp3
    case aac
    case alac
    case flac
    case wav
    case aiff

    var id: String { self.rawValue }

    var displayName: String {
        switch self {
        case .mp3: return "MP3"
        case .aac: return "AAC (Lossy)"
        case .alac: return "Apple Lossless"
        case .flac: return "FLAC"
        case .wav: return "WAV"
        case .aiff: return "AIFF"
        @unknown default: return "Unknown type"
        }
    }

    var utType: UTType {
        switch self {
        case .mp3:
            return .mp3
        case .aac:
            return UTType(filenameExtension: "aac") ?? .audio
        case .alac:
            return UTType(filenameExtension: "alac") ?? .audio
        case .flac:
            return UTType(filenameExtension: "flac") ?? .audio
        case .wav:
            return .wav
        case .aiff:
            return .aiff
        @unknown default:
            return .audio
        }
    }

    static var allowedImportTypes: [UTType] {
        let types = allCases.map { $0.utType }
        return Array(Set(types))
    }
}
