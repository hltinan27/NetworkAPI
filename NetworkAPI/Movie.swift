//
//  Movie.swift
//  Movies
//
//  Created by Halit inan on 31.01.2020.
//  Copyright © 2020 Halit inan. All rights reserved.
//

import Foundation

public struct Movie: Codable, Equatable {
    
    public enum CodingKeys: String, CodingKey {
        case artistName
        case releaseDate
        case name
        case copyright
        case image = "artworkUrl100"
        case genres
    }
    
    
    public let artistName: String
    public let releaseDate: Date
    public let name: String
    public let copyright: String?
    public let image: URL
    public let genres: [Genre]
}

public struct Genre: Codable, Equatable {
    public let name: String?
}


public struct TopMoviesResponse: Codable {
    
    private enum RootCodingKeys: String, CodingKey {
        case feed
    }
    
    private enum FeedCodingKeys: String, CodingKey {
        case results
    }
    
    public let results: [Movie]
    
    init(results: [Movie]) {
        self.results = results
    }
    
    public init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        let feedContainer = try rootContainer.nestedContainer(keyedBy: FeedCodingKeys.self, forKey: .feed)
        self.results = try feedContainer.decode([Movie].self, forKey: .results)
    }
}
