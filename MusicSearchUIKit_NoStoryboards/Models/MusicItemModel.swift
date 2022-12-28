import Foundation

public struct MusicItemModel: Codable, Identifiable, Equatable {
    
    public let id : Int
    public let wrapperType: WrapperType
    public let kind: String
    public let trackName: String
    public let artistName: String
    public let collectionName: String
    public let artworkUrl100: String
    public let artworkUrl60: String
    public let previewUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case wrapperType
        case kind
        case trackName
        case artistName
        case collectionName
        case artworkUrl100
        case artworkUrl60
        case previewUrl
    }
}

public enum WrapperType: String, Equatable, Codable {
    case track
    case collection
    case artist
}

public enum MusicSearchError: Error {
    case requestFailed
    case networkResponseInvalid
    case jsonDecodeFailed
    case urlInvalid
}

public enum State: Equatable {
    
    case idle
    case loading
    case loaded ( results : [MusicItemModel])
    case error
    
    var results: [MusicItemModel]? {
        switch self {
        case .loaded(results: let result):
            return result
        default:
            return nil
        }
    }
}

public enum ImageDownloaderError: Error {
    case requestFailed
    case networkResponseInvalid
    case imageInitializationFailed
}
