//
//  Recipe.swift
//  RecipesTestApp
//
//  Created by Jason Lew-Rapai on 10/16/24.
//

import Foundation

struct Recipe: Codable, Identifiable, Equatable {
    let id: String
    let name: String
    let cuisine: String
    let photoURLLarge: String
    let photoURLSmall: String
    let sourceURL: String?
    let youtubeURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name
        case cuisine
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
    
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.id == rhs.id
        && lhs.name == rhs.name
        && lhs.cuisine == rhs.cuisine
        && lhs.photoURLLarge == rhs.photoURLLarge
        && lhs.photoURLSmall == rhs.photoURLSmall
        && lhs.sourceURL == rhs.sourceURL
        && lhs.youtubeURL == rhs.youtubeURL
    }
}
