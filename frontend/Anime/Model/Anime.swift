//
//  Anime.swift
//  Anime
//
//  Created by Harshith Harijeevan on 10/15/25.
//

import Foundation

struct TopAnimeResponse: Codable {
    let top_animes: [Anime]
}

struct Anime: Identifiable, Codable {
    let id: Int
    let title: String
    let synopsis: String
    let image_url: String
    let score: Double
    let type: String
}

struct RecommendationEntry: Identifiable, Codable {
    let mal_id: Int
    let title: String
    let image_url: String
    let url: String
    
    var id: Int { mal_id }
}

struct User: Codable {
    let url: String
    let username: String
}

struct RecommendationItem: Identifiable, Codable {
    // Local-only identifier; not part of the JSON
    var id = UUID()
    let entries: [RecommendationEntry]
    let content: String
    let user: User

    // Exclude `id` from Codable so decoding won't expect it
    private enum CodingKeys: String, CodingKey {
        case entries, content, user
    }
}

struct RecommendationResponse: Codable {
    let recommendations: [RecommendationItem]
}
